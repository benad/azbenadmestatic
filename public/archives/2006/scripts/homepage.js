var aboutPane, bioPane, contactPane, tocPane;

function hidePanes() {
    bioPane.hide();
    contactPane.hide();
    aboutPane.hide();
}
var myrules = {
    '#about_link' : function(el) {
        el.onclick = function() {
            hidePanes();
            aboutPane.toggle();
            return false;
        }
    },
    '#bio_link' : function(el) {
        el.onclick = function() {
            hidePanes();
            bioPane.toggle();
            return false;
        }
    },
    '#contact_link' : function(el) {
        el.onclick = function() {
            hidePanes();
            contactPane.toggle();
            return false;
        }
    }
};
Behaviour.register(myrules);
function init() {
    aboutPane = new fx.Combo('about', {height:true, opacity:true});
    bioPane = new fx.Combo('bio', {height:true, opacity:true});
    contactPane = new fx.Combo('contact', {height:true, opacity:true});
    tocPane = new fx.Width('toc');
    var titleEffect = new fx.Opacity('title', {duration: 1000,
    onComplete: function()
      {
        tocPane.toggle();
      }
    });

    hidePanes();
    tocPane.hide();
    titleEffect.hide();
    
    titleEffect.toggle();
}

