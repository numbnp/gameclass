/*global jQuery */
/*
 *  This jQuery plugin fixes the issue reported on chromiumembedded project:
 *  https://code.google.com/p/chromiumembedded/issues/detail?id=1208
 *  It should be called on selectors that represent <select> tags in the DOM
 *  The plugin generates a <div> tag containing <p> tags for each <option> that are already present in the DOM
 *  When the user clicks on the <select>, the default event is cancelled and the generated <div> is positioned
 *    under the <select> with a style that is similar to the Windows 7 built-in dropdown.
 */
(function ($) {
    "use strict";

    function selectOption(select, fakeOption, settings) {
        select.val(fakeOption.data("realOption").val()).change();
        select.next("p." + settings.hoveredOptionClass).removeClass(settings.hoveredOptionClass);
        fakeOption.addClass(settings.hoveredOptionClass);
    }

    function getSelected(options, settings) {
        return options.filter(function (element) {
            return element.hasClass(settings.hoveredOptionClass);
        })[0];
    }

    $.fn.fixCEFSelect = function (pluginOptions) {

        // the plugin should work also when the selector matches more than one element
        return this.each(function () {

            // storing variables local to each element that matches the selector which the plugin was called on
            var dropdown, options,
                defaults = {
                    selectClass: "cef-select-offset-fix",
                    dropdownClass: "cef-dropdown-offset-fix",
                    hoveredOptionClass: "cef-optionhover-offset-fix",
                    fadeTime: 300
                },
                settings = $.extend({}, defaults, pluginOptions),
                that = $(this);

            that.addClass(settings.selectClass);

            /*jslint unparam: true*/
            // convert <option> elements already present in the DOM to <p> elements that will be used to display the dropdown
            options = that.children("option").map(function (index, element) {
                var option = $("<p/>").html(element.innerHTML);

                // store the <option> elements as jQuery objects in each <p>
                option.data("realOption", $(element));

                option.on("click", function (event) {
                    selectOption(that, option, settings);
                    dropdown.fadeOut(settings.fadeTime);
                    that.focus();
                });

                option.on("mouseenter mousemove", function () {
                    dropdown.find("." + settings.hoveredOptionClass).removeClass(settings.hoveredOptionClass);
                    $(this).addClass(settings.hoveredOptionClass);
                });

                if (element.selected) {
                    selectOption(that, option, settings);
                }

                return option;
            }).toArray();
            /*jslint unparam: false*/

            dropdown = $("<div/>").addClass(settings.dropdownClass).append(options);
            dropdown.insertAfter(that);

            // remove existing dropdown from DOM - prevents creating two dropdowns if the plugin is called multiple times
            if (that.data("dropdown")) {
                that.data("dropdown").remove();
            }
            that.data("dropdown", dropdown);

            that.on("mousedown", function (event) {
                var target = $(event.target);
                event.preventDefault();
                // don't want to execute mousedown event for the html element
                event.stopPropagation();

                if (dropdown.is(":visible")) {
                    dropdown.fadeOut(settings.fadeTime);
                } else {
                    dropdown.css({
                        top: target.position().top + target.height() + parseInt(target.css("margin-top"), 10) + parseInt(target.css("margin-bottom"), 10),
                        left: target.position().left + parseInt(target.css("margin-left"), 10),
                        width: target.width()
                    });
                    dropdown.fadeIn(settings.fadeTime);
                    target.focus();
                }
            });

            // checks for clicking outside of the dropdown
            $("html").mousedown(function (event) {
                var target = $(event.target);
                if (!target.is(dropdown) && !target.parents().is(dropdown) && dropdown.is(":visible")) {
                    dropdown.fadeOut(settings.fadeTime);
                    that.blur();
                }
            });

            // trigger default key events when using the select
            $("html").keydown(function (event) {
                var selectedIndex, hovered;

                if (dropdown.is(":visible")) {
                    hovered = getSelected(options, settings);
                    switch (event.which) {
                        case 9: // Tab
                            selectOption(that, hovered, settings);
                            dropdown.fadeOut(settings.fadeTime);
                            break;
                        case 13: // Enter
                            selectOption(that, hovered, settings);
                            dropdown.fadeOut(settings.fadeTime);
                            break;
                        case 38: // Up arrow
                            selectedIndex = options.indexOf(hovered);
                            // it doesn't go above the first element
                            if (selectedIndex > 0) {
                                hovered.removeClass(settings.hoveredOptionClass);
                                options[selectedIndex - 1].addClass(settings.hoveredOptionClass);
                            }
                            break;
                        case 40: // Down arrow
                            selectedIndex = options.indexOf(hovered);
                            // it doesn't go below the last element
                            if (selectedIndex > -1 && selectedIndex < options.length - 1) {
                                hovered.removeClass(settings.hoveredOptionClass);
                                options[selectedIndex + 1].addClass(settings.hoveredOptionClass);
                            }
                            break;
                    }
                } else if (that.is(":focus") && event.which === 32) { // if it's not visible, is focused and Space is pressed
                    dropdown.css({
                        top: that.position().top + that.height() + parseInt(that.css("margin-top"), 10) + parseInt(that.css("margin-bottom"), 10),
                        left: that.position().left + parseInt(that.css("margin-left"), 10),
                        width: that.width()
                    });
                    dropdown.fadeIn(settings.fadeTime);
                }
            });
        });
    };

}(jQuery));