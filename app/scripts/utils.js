(function() {
  'use strict';

  window._ = {
    each: function (ar, fn) {
      for (var i = 0; i < ar.length; i++) {
        console.log(ar[i]);
        fn.call(this, ar[i]);
      }
    },

    throttle: function(fn, threshhold, scope) {
      threshhold = threshhold || 250;
      var last,
          deferTimer;
      return function () {
        var context = scope || this;

        var now = +new Date(),
            args = arguments;
        if (last && now < last + threshhold) {
          // hold on to it
          clearTimeout(deferTimer);
          deferTimer = setTimeout(function () {
            last = now;
            fn.apply(context, args);
          }, threshhold);
        } else {
          last = now;
          fn.apply(context, args);
        }
      };
    }
  };

}());
