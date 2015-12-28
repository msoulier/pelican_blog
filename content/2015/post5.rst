A working logger
================

:date: 2015-12-28 11:00
:category: Technology
:author: Michael P. Soulier
:tags: C++
:slug: a-working-logger

So it took some work, and likely there are better ways to do this, but this
logger satisfies my current needs in providing multiple levels of logging,
and an iostream interface to make composing strings simpler. First some
includes and definitions.

.. code-block:: C++

    #include <stdio.h>
    #include <ostream>
    #include <boost/thread.hpp>
    #include <boost/thread/mutex.hpp>

    #define LOGLEVEL_TRACE 0
    #define LOGLEVEL_DEBUG 10
    #define LOGLEVEL_INFO 20
    #define LOGLEVEL_WARN 30
    #define LOGLEVEL_ERROR 40

Then my thread-local buffer.

.. code-block:: C++

    extern boost::thread_specific_ptr<std::stringstream> tls_buffer;

The intention here is to "collect" logs from successive calls to the << operator
in one line, using a thread-local buffer to prevent each thread from
stepping on one another. At the end of the line, we will then synchronize
around the write to the std::ostream and flush the buffer. There might be a
way to declare the tls_buffer inside of the class but my C++ chops are
currently insufficient. 

I am also aware that one could use a temporary variable hack to get a
thread-local buffer without using boost here, but the examples that I found
showing this were very hard for me to understand. This, I understand so I'm
going with it for now.

Now, my logger is broken up into two classes. The main logger, and the
logger handlers that are used to do the actual logging at each level
(ie. debug, info, error, etc). This handler is where the << operator
overloading magic happens.

.. code-block:: C++

    class MLoggerHandler
    {
    public:
        MLoggerHandler(boost::mutex& mutex,
                    std::ostream& ostream,
                    int threshold,
                    std::string prefix);
        ~MLoggerHandler();
        void setLevel(int level);

        template <class T>
        // For handling << from any object.
        MLoggerHandler& operator <<(T input) {
            // Only log if the level is set above our threshold.
            if (m_threshold >= m_level) {
                if (tls_buffer.get() == NULL) {
                    tls_buffer.reset(new std::stringstream());
                }
                if (tls_buffer->str().length() == 0) {
                    *tls_buffer << localDateTime() << " " << m_prefix << ": " << input;
                }
                else {
                    *tls_buffer << input;
                }
            }
            return *this;
        }
        // For handling std::endl
        std::ostream& operator <<(std::ostream& (*f)(std::ostream&)) {
            // Only log if the level is set above our threshold.
            if (m_threshold >= m_level) {
                boost::lock_guard<boost::mutex> lock{m_mutex};
                // Flush the buffer
                m_ostream << tls_buffer->str();
                f(m_ostream);
                // Clear the buffer
                tls_buffer->str("");
            }
            return m_ostream;
        }
    private:
        // A mutex passed in from the main logger for synchronization.
        boost::mutex& m_mutex;
        // The logging level.
        int m_level;
        // The output stream.
        std::ostream& m_ostream;
        // The threshold for logging for this handler.
        int m_threshold;
        // The string prefix for logging.
        std::string m_prefix;
        // Return the current date and time as a localized string.
        const std::string localDateTime();
    };

.. **

Note that the << overload takes any type capable of itself using the <<
operator, while there's a separate method required to implement handling
for the `std::endl` at the end of the line. This allows us to knwo when the
line is terminated, to write and flush the buffer, but it also imposes the
limitation that the user of this logger *must* provide the `std::endl` to
terminate the line or the logger won't work properly. These handlers are
returned as a result of calling the individual level methods in the main
logger, like `info()`, `debug()`, etc.

Also note that when the thread-local buffer is empty, that is used as an
indication of building the beginning of the line, and thus starting with
a logging level prefix and a timestamp.

And now the main logger...

.. code-block:: C++

    /*
    * The MLogger (Mike-logger) is a thread-safe C++ logger using the iostream operators.
    * To use it, you must invoke a logging level handler which will return an
    * MLoggerHandler reference, and then terminate your line with std::endl to ensure
    * that the buffer is flushed and the line terminated with a newline.
    */
    class MLogger
    {
    public:
        MLogger();
        MLogger(std::string name);
        ~MLogger();
        // Set the current logging level
        void setLevel(int level);
        // Get the current logging level
        int getLevel();
        // Convenience methods for trace level log.
        MLoggerHandler& trace();
        // Convenience methods for debug level log
        MLoggerHandler& debug();
        // Convenience methods for info level log
        MLoggerHandler& info();
        // Convenience methods for warning level log
        MLoggerHandler& warn();
        // Convenicence methods for error level log
        MLoggerHandler& error();
    private:
        // The logger name.
        std::string m_name;
        // The current log level.
        int m_level;
        // The output stream for the logger.
        std::ostream& m_ostream;
        // The mutex used for synchronization.
        boost::mutex m_mutex;
        // Trace handler
        MLoggerHandler m_trace_handler;
        // Debug handler
        MLoggerHandler m_debug_handler;
        // Info handler
        MLoggerHandler m_info_handler;
        // Warn handler
        MLoggerHandler m_warn_handler;
        // Error handler
        MLoggerHandler m_error_handler;
    };

.. **

The implementation is nothing special, but for completeness here it is.

.. code-block:: C++

    boost::thread_specific_ptr<std::stringstream> tls_buffer;

    MLoggerHandler::MLoggerHandler(boost::mutex& mutex,
                                std::ostream& ostream,
                                int threshold,
                                std::string prefix)
        : m_mutex(mutex)
        , m_level(LOGLEVEL_INFO)
        , m_ostream(ostream)
        , m_threshold(threshold)
        , m_prefix(prefix)
    { }

    MLoggerHandler::~MLoggerHandler() { }

    void MLoggerHandler::setLevel(int level) {
        m_level = level;
    }

    const std::string MLoggerHandler::localDateTime() {
        const char *format = "%b %d %Y @ %X %Z";
        std::time_t t = std::time(NULL);
        char buffer[128];
        if (std::strftime(buffer, sizeof(buffer), format, std::localtime(&t))) {
            return std::string(buffer);
        }
        else {
            return "";
        }
    }

    MLogger::MLogger(std::string name)
        : m_name(name)
        , m_level(LOGLEVEL_INFO)
        , m_ostream(std::cerr)
        , m_trace_handler(MLoggerHandler(m_mutex, m_ostream, LOGLEVEL_TRACE, "TRACE"))
        , m_debug_handler(MLoggerHandler(m_mutex, m_ostream, LOGLEVEL_DEBUG, "DEBUG"))
        , m_info_handler(MLoggerHandler(m_mutex, m_ostream, LOGLEVEL_INFO, "INFO"))
        , m_warn_handler(MLoggerHandler(m_mutex, m_ostream, LOGLEVEL_WARN, "WARN"))
        , m_error_handler(MLoggerHandler(m_mutex, m_ostream, LOGLEVEL_ERROR, "ERROR"))
        { }

    MLogger::MLogger() : MLogger("No name") { }

    MLogger::~MLogger() { }

    int MLogger::getLevel() {
        return m_level;
    }

    void MLogger::setLevel(int level) {
        m_level = level;
        // And set it on all of the logger handlers.
        m_trace_handler.setLevel(level);
        m_debug_handler.setLevel(level);
        m_info_handler.setLevel(level);
        m_warn_handler.setLevel(level);
        m_error_handler.setLevel(level);
    }

    MLoggerHandler& MLogger::trace() {
        return m_trace_handler;
    }

    MLoggerHandler& MLogger::debug() {
        return m_debug_handler;
    }

    MLoggerHandler& MLogger::info() {
        return m_info_handler;
    }

    MLoggerHandler& MLogger::warn() {
        return m_warn_handler;
    }

    MLoggerHandler& MLogger::error() {
        return m_error_handler;
    }

.. **

Currently, I'm using this through a simple shared global called `logger`,
so you then just use it like so:

.. code-block:: C++

    MLogger logger;

    logger.setLevel(LOGLEVEL_INFO);

    // This produces no output at INFO logging level.
    logger.debug() << "The current value of foo is " << foo << std::endl;

    // This produces output.
    logger.info() << "The current value of bar is " << bar << std::endl;

So, it works, it's thread safe, and I don't have to manually build my own
logging strings with `std::stringstream`, saving endless lines of code. I'm
certain that it can be improved, I can certainly build in facilities like
log rotation, compression, etc. But, it's a start.
