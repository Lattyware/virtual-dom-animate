var nextTick = require('next-tick');
var document = require("global/document")

Elm.Native = Elm.Native || {};
Elm.Native.VirtualDom = Elm.Native.VirtualDom || {};
Elm.Native.VirtualDom.Animate = Elm.Native.VirtualDom.Animate || {};

Elm.Native.VirtualDom.Animate.make = function(localRuntime) {
  if ('values' in Elm.Native.VirtualDom.Animate) {
    return Elm.Native.VirtualDom.Animate.values;
  }

	var Task = Elm.Native.Task.make(localRuntime);
	var VirtualDom = Elm.Native.VirtualDom.make(localRuntime);

  var HOOK_SUFFIX = "---HOOK_UNIQUE_SUFFIX"

  function animatedAttribute(name, initialValue, finalValue) {
    return {
      key: name + HOOK_SUFFIX,
      value: new AnimatedValue(name, initialValue, finalValue)
    }
  }

  function AnimatedValue(name, initialValue, finalValue) {
    if (!(this instanceof AnimatedValue)) {
      return new AnimatedValue(initialValue, finalValue);
    }

    this.name = name
    this.value = initialValue;
    this.finalValue = finalValue;
  }

  AnimatedValue.prototype.hook = function(node, property) {
    node.setAttribute(this.name, this.value);
    if (!document.body.contains(node)) {
      nextTick(function () {
        node.setAttribute(this.name, this.finalValue);
      }.bind(this))
    }
  }

  return Elm.Native.VirtualDom.Animate.values = {
    animatedAttribute: F3(animatedAttribute)
  };
}
