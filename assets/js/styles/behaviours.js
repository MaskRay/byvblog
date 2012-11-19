jQuery.noConflict();
jQuery(document).ready(function(){

/*AUDIO / VIDEO PLAYER STARTS*/
jQuery('audio,video').mediaelementplayer();
 /*AUDIO / VIDEO PLAYER ENDS*/
	
/*ACCORDION JQUERY STARTS*/	
/********** jquery toogle function **********/
jQuery('#toggle-view li').click(function () {
	var text = jQuery(this).children('p');

	if (text.is(':hidden')) {
		text.slideDown('200');
		jQuery(this).find('.toggle-indicator').text('-');
	} else {
		text.slideUp('200');
		jQuery(this).find('.toggle-indicator').text('+');
	}
});
/*ACCORDION JQUERY ENDS*/	

/*GOOGLE MAPS STARTS*/
if ( jQuery( '#map' ).length && jQuery() ) {
var jQuerymap = jQuery('#map');
	jQuerymap.gMap({	
	address: 'Level 13, 2 Elizabeth St, Melbourne Victoria 3000 Australia',	 
	zoom: 18,
	markers: [
	{ 'address' : 'Level 13, 2 Elizabeth St, Melbourne Victoria 3000 Australia' },]	
			});
		 } 
/*GOOGLE MAPS STARTS*/

/*FIT VIDEOS STARTS*/
jQuery(".container").fitVids();
/*FIT VIDEOS ENDS*/
	
	
/*WIDTH RESIZE*/	
 var currentWindowWidth = jQuery(window).width();
	jQuery(window).resize(function(){
		currentWindowWidth = jQuery(window).width();
	});
/*WIDTH RESIZE*/

/*PRETTY PHOTO STARTS*/
	jQuery("a[data-rel^='prettyPhoto'], a.prettyPhoto, a[rel^='prettyPhoto']").prettyPhoto({
		overlay_gallery: false
	});
/*PRETTY PHOTO ENDS*/	

/*BACK TO TOP*/
jQuery(document).ready(function() { jQuery('.backtotop').click(function(){ jQuery('html, body').animate({scrollTop:0}, 'slow'); return false; }); });
/*BACK TO TOP*/

 
 /*PORTFOLIO ITEM HOVER*/
if ( jQuery( '.portfolio-item-hover-content' ).length && jQuery() ) {
function hover_effect() {  
jQuery('.portfolio-item-hover-content').hover(function() {
         jQuery(this).find('div,a').stop(0,0).removeAttr('style');
         jQuery(this).find('.hover-options').animate({opacity: 0.9}, 'fast');
         jQuery(this).find('a').animate({"top": "60%" });
    }, function() {
         jQuery(this).find('.hover-options').stop(0,0).animate({opacity: 0}, "fast");
         jQuery(this).find('a').stop(0,0).animate({"top": "150%"}, "slow");
         jQuery(this).find('a.zoom').stop(0,0).animate({"top": "150%"}, "slow");
       });
	}
hover_effect();
}

/*PORTFOLIO ITEM HOVER*/
		
/*HOMEPAGE CAROUSEL STARTS*/
(function() {
	var jQuerycarousel = jQuery('#projects-carousel');
	if( jQuerycarousel.length ) {
		var scrollCount;
		if( jQuery(window).width() < 480 ) {
				scrollCount = 1;
		} else if( jQuery(window).width() < 768 ) {
				scrollCount = 1;
		} else if( jQuery(window).width() < 960 ) {
				scrollCount = 3;
		} else {
				scrollCount = 4;
		}
	jQuerycarousel.jcarousel({
		animation : 600,
		easing    : 'easeOutCirc',
		scroll    : scrollCount, 
		initCallback:   function() {jQuerycarousel.removeClass('loading')},
	});
}
})();
/*HOMEPAGE CAROUSEL ENDS*/

/*RESPONSIVE MAIN NAVIGATION STARTS*/
   mainNavChildren(jQuery("#main-navigation > ul") , 0);
	function mainNavChildren(parent , level){
		jQuery(parent).children("li").each(function(i , obj){
			var label = "";
			for(var k = 0 ; k < level ; k++){
				label += "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			label += jQuery(obj).children("a").text();
			jQuery("#responsive-main-nav-menu").append("<option value = '" + jQuery(obj).children("a").attr("href") + "'>" + label + "</option>");
			
			if(jQuery(obj).children("ul").size() == 1){
				mainNavChildren(jQuery(obj).children("ul") , level + 1);
			}
		});
	}
/*RESPONSIVE MAIN NAVIGATION STARTS*/	

/*RESPONSIVE SOCIAL NAVIGATION STARTS*/	
	 mainNavSocial(jQuery("#social-icons > ul") , 0);
	function mainNavSocial(parent , level){
		jQuery(parent).children("li").each(function(i , obj){
			var label = "";
			for(var k = 0 ; k < level ; k++){
				label += "&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			label += jQuery(obj).children("a").text();
			jQuery("#responsive-social-menu").append("<option value = '" + jQuery(obj).children("a").attr("href") + "'>" + label + "</option>");
			
			if(jQuery(obj).children("ul").size() == 1){
				mainNavSocial(jQuery(obj).children("ul") , level + 1);
			}
		});
	}
 /*RESPONSIVE SOCIAL NAVIGATION STARTS*/	

/*CAMERA SLIDERS STARTS*/	 
 if ( jQuery( '#camera_wrap_1' ).length && jQuery()) {
 jQuery('#camera_wrap_1').camera({
	height: '350px',
	loader: 'bar',
	pagination: false,
	thumbnails: true
 });
 }
if ( jQuery( '#camera_wrap_2' ).length && jQuery()) {
 jQuery('#camera_wrap_2').camera({
	height: '350px',
	thumbnails: true
 });
 }
/*CAMERA SLIDERS ENDS*/	  
 
/*TWITTER FEEDS STARTS (CHANGE USERNAME TO YOUR OWN USERNAME)*/	 
 if ( jQuery( '.tweet' ).length && jQuery()) {
jQuery(".tweet").tweet({
	 username: "trendywebstar",
	 join_text: null,
	 avatar_size: null,
	 count: 1,
	 auto_join_text_default: "we said,", 
	 auto_join_text_ed: "we",
	 auto_join_text_ing: "we were",
	 auto_join_text_reply: "we replied to",
	 auto_join_text_url: "we were checking out",
	 loading_text: "loading tweets..."
 });
 }
/*TWITTER FEEDS ENDS*/

/*TIPSY STARTS*/
if ( jQuery().tipsy ) {
	jQuery("#social-01").tipsy({gravity: 'n'});
	jQuery("#social-02").tipsy({gravity: 'n'});
	jQuery("#social-03").tipsy({gravity: 'n'});
	jQuery("#social-04").tipsy({gravity: 'n'});
	jQuery("#social-05").tipsy({gravity: 'n'});
	jQuery("#social-06").tipsy({gravity: 'n'});
	jQuery("#social-07").tipsy({gravity: 'n'});
	jQuery("#social-07").tipsy({gravity: 'n'});
	jQuery("#social-08").tipsy({gravity: 'n'});
	jQuery("#social-09").tipsy({gravity: 'n'});
	jQuery("#social-10").tipsy({gravity: 'n'});
	jQuery("#social-11").tipsy({gravity: 'n'});
	jQuery("#team-01").tipsy({gravity: 's'});
	}
/*TIPSY ENDS*/


   
/* NAVIGATION JQUERY STARS */   
if ( jQuery( '#main-navigation' ).length && jQuery() ) {
var arrowimages={down:['downarrowclass', './images/plus.png', 23], right:['rightarrowclass', './images/plus-white.png']}
var jqueryslidemenu={
animateduration: {over: 200, out: 100}, //duration of slide in/ out animation, in milliseconds
buildmenu:function(menuid, arrowsvar){
	jQuery(document).ready(function(jQuery){
		var jQuerymainmenu=jQuery("#"+menuid+">ul")
		var jQueryheaders=jQuerymainmenu.find("ul").parent()
		jQueryheaders.each(function(i){
			var jQuerycurobj=jQuery(this)
			var jQuerysubul=jQuery(this).find('ul:eq(0)')
			this._dimensions={w:this.offsetWidth, h:this.offsetHeight, subulw:jQuerysubul.outerWidth(), subulh:jQuerysubul.outerHeight()}
			this.istopheader=jQuerycurobj.parents("ul").length==1? true : false
			jQuerysubul.css({top:this.istopheader? this._dimensions.h+"px" : 0})
			jQuerycurobj.children("a:eq(0)").css(this.istopheader? {paddingRight: arrowsvar.down[2]} : {}).append(
				'<span class="' + (this.istopheader? arrowsvar.down[0] : arrowsvar.right[0])
				+ '" />'
			)
			jQuerycurobj.hover(
				function(e){
					var jQuerytargetul=jQuery(this).children("ul:eq(0)")
					this._offsets={left:jQuery(this).offset().left, top:jQuery(this).offset().top}
					var menuleft=this.istopheader? 0 : this._dimensions.w
					menuleft=(this._offsets.left+menuleft+this._dimensions.subulw>jQuery(window).width())? (this.istopheader? -this._dimensions.subulw+this._dimensions.w : -this._dimensions.w) : menuleft
					if (jQuerytargetul.queue().length<=1) //if 1 or less queued animations
						jQuerytargetul.css({left:menuleft+"px", width:this._dimensions.subulw+'px'}).slideDown(jqueryslidemenu.animateduration.over)
				},
				function(e){
					var jQuerytargetul=jQuery(this).children("ul:eq(0)")
					jQuerytargetul.slideUp(jqueryslidemenu.animateduration.out)
				}
			) //end hover
			jQuerycurobj.click(function(){
				jQuery(this).children("ul:eq(0)").hide()
			})
		}) //end jQueryheaders.each()
		jQuerymainmenu.find("ul").css({display:'none', visibility:'visible'})
	}) //end document.ready
}
}
jqueryslidemenu.buildmenu("main-navigation", arrowimages)

}
 /* NAVIGATION JQUERY ENDS */ 
 

 
 /*
 /* QUICKSAND PLUGIN JQUERY STARS */

  var jQueryfilterType = jQuery('#filterable li.active a').attr('class');
  var jQueryholder = jQuery('ul.portfolio-items');
  var jQuerydata = jQueryholder.clone();
	jQuery('#filterable li a').click(function(e) {
		jQuery('#filterable li').removeClass('active');
		var jQueryfilterType = jQuery(this).attr('data-type');
		jQuery(this).parent().addClass('active');
		
		if (jQueryfilterType == 'all') {
			var jQueryfilteredData = jQuerydata.find('li');
		} 
		else {
			var jQueryfilteredData = jQuerydata.find('li[data-type~="' + jQueryfilterType + '"]');
		}
		//alert(jQueryfilteredData);
		jQueryholder.quicksand(jQueryfilteredData, {
			duration: 500,
			useScaling: false,
			adjustHeight:false,
			easing: 'swing',
			enhancement:function(){
			 hover_effect(); 
			}
		});
		return false;
	});

/* QUICKSAND PLUGIN JQUERY ENDS */  

jQuery('#social-links a').attr('target', '_blank');



});  /* JQUERY ENDS */

