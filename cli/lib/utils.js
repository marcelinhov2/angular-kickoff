(function() {
  var Utils,
    __slice = [].slice;

  Utils = (function() {
    function Utils() {}

    Utils.prototype.each = function(arr, func, index) {
      if (index == null) {
        index = 0;
      }
      if (index < arr.length) {
        return [func(arr[index], index)].concat(__slice.call(this.each(arr, func, index + 1)));
      } else {
        return [];
      }
    };

    Utils.prototype.camelize = function(input) {
      var pieces;
      input = this.lowercase(input);
      pieces = input.split(/[\W_-]/);
      return this.each(pieces, this.capitalize).join("");
    };

    Utils.prototype.capitalize = function(input) {
      return input.charAt(0).toUpperCase() + input.slice(1);
    };

    Utils.prototype.lowercase = function(input) {
      return input.toLowerCase();
    };

    Utils.prototype.underscore = function(input) {
      var pieces;
      pieces = input.replace(/([A-Z])/g, '_$1').split(/[\W_-]/).filter(function(n) {
        return !!n;
      });
      return this.each(pieces, this.lowercase).join("_");
    };

    Utils.prototype.pluralize = function(input) {
      if (input.slice(-1) === "y") {
        return input = this.lowercase(input.slice(0, -1) + "ies");
      } else {
        return input = this.lowercase(input + "s");
      }
    };

    return Utils;

  })();

  module.exports = new Utils;

}).call(this);
