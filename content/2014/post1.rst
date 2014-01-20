Validation with Server-side call in AngularJS
=============================================

:date: 2014-01-19 19:30
:category: Technology
:author: Michael P. Soulier
:tags: AngularJS, ReST
:slug: validation-server-call-angularjs

I've been playing with `AngularJS`_ for a little while, and in trying to
understand how to validate a user's data as it's being entered, it didn't take
long to find that to check with the server for some validation rules, like
uniqueness constraints.

This presented a problem since the built-in validators know nothing about the
data on the server. I looked into the issue and found that creating my own
directive was the way to go. Difficult when I'm an AngularJS newbie and I
barely understand such things, but luckily the AngularJS online community was
helpful. To validate the uniqeness of an "ICP" (don't ask) when the user stops
typing, it's not overly difficult.

.. code-block:: javascript

    app.directive('uniqueIcpName', function($http, $timeout) {
        var promise;
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function(scope, elem, attrs, ctrl) {
                //when the scope changes, check
                scope.$watch(attrs.ngModel, function(value) {
                    // if there was a previous attempt, stop it.
                    $timeout.cancel(promise);

                    console.log(attrs.uniqueIcpName);

                    // Determine the url based on whether this is an add or a
                    // modify.
                    var url;
                    if (attrs.uniqueIcpName === "add") {
                        url = '/valid/icp/add/name/' + value + '/';
                    } else {
                        url = '/valid/icp/modify/name/' + value + '/';
                    }

                    // start a new attempt with a delay to keep it from
                    // getting too "chatty".
                    promise = $timeout(function() {
                        // call to some API that returns { isValid: true } or
                        // { isValid: false }
                        $http.get(url)
                            .success(
                                function(data) {
                                    ctrl.$setValidity('uniqueIcpName',
                                                    data.isValid);
                                });
                    }, 500);
                })
            }
        }
    })

The timeout is a neat trick someone taught me, so you launch the event on every
keypress, but on the next keypress you cancel the previous one, and put in a
500ms delay on the ReST call, so you don't really make the request until the
user stops typing for a full half second. Meanwhile I put in a little attribute
check based on creation vs. modification of the data, since uniqueness checks
must exclude the current object on a modification.

Then all you need is the server-side returning an `isValid` attribute, which
should have a boolean value. Simple, and it works.

.. _`AngularJS`: http://www.angularjs.org
