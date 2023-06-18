window._ = require('lodash');
window.$ = window.jQuery = require('jquery');
window.jQuery = window.$;

/**
 This is only used for the ajax call
 @note If you need to change please contact [CORE SUPPORT TEAM]
 @example :
 $('.button').on('click', function() {
   doAjax({url: `your_url`, `data`: `your_data`,'successCallbackFunction',`your success callback function`});
 });
 */

// (() => {
//     'use strict'
//     alert('do-ajax is loading...');
// })


function isValidURL(string) {
    var res = string.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    return (res !== null)
};

const doAjax = function doAjax(params) {
    const defaults = {
        requestType: "GET", contentType: 'application/x-www-form-urlencoded; charset=UTF-8', dataType: 'json',
    };

    const {
        url,
        requestType,
        contentType,
        dataType,
        data,
        beforeSendCallbackFunction,
        successCallbackFunction,
        completeCallbackFunction,
        errorCallBackFunction
    } = {...defaults, ...params};

    $.ajax({
        url,
        crossDomain: true,
        type: requestType,
        contentType,
        dataType,
        data,
        beforeSend: function (jqXHR, settings) {
            if (typeof beforeSendCallbackFunction === "function") {
                beforeSendCallbackFunction();
            }
        },
        success: function (data, textStatus, jqXHR) {
            if (typeof successCallbackFunction === "function") {
                successCallbackFunction(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (typeof errorCallBackFunction === "function") {
                errorCallBackFunction(errorThrown);
            }

        },
        complete: function (jqXHR, textStatus) {
            if (typeof completeCallbackFunction === "function") {
                completeCallbackFunction();
            }
        }
    });
}

window.doAjax = doAjax;

export {doAjax,isValidURL};