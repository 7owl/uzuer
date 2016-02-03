(function(Handlebars) {
	Handlebars.registerHelper('compare', function(left, operator, right, options) {
        if (arguments.length < 3) {
          throw new Error('Handlerbars Helper "compare" needs 2 parameters');
        }
        var operators = {
          '==':     function(l, r) {return l == r; },
          '===':    function(l, r) {return l === r; },
          '!=':     function(l, r) {return l != r; },
          '!==':    function(l, r) {return l !== r; },
          '<':      function(l, r) {return l < r; },
          '>':      function(l, r) {return l > r; },
          '<=':     function(l, r) {return l <= r; },
          '>=':     function(l, r) {return l >= r; },
          'typeof': function(l, r) {return typeof l == r; }
        };

        if (!operators[operator]) {
          throw new Error('Handlerbars Helper "compare" doesn\'t know the operator ' + operator);
        }

        var result = operators[operator](left, right);

        if (result) {
          return options.fn(this);
        } else {
          return options.inverse(this);
        }
    });
})(Handlebars);

var RoomDetail = Backbone.Model.extend({
	idAttribute: 'roomSeq',
	urlRoot: 'app/getSharingRoomDetail'
});

var RoomDetailView = Backbone.View.extend({
	initialize: function(){
		this.listenTo(this.model, "change", this.render);
	},
	el : '#roomDetail',
	template : Handlebars.compile($("#tmp_room_detail").html()),
	render : function() {
		var pic = this.model.attributes.picture;
		if(_.isString(pic) && pic!=""){
			var picture;
			if(pic.indexOf(",")!=-1){
				var strs = pic.split(",");
				for(var i=0 ; i < 3 ; i++){
					if(i < strs.length-1)
					{
						this.model.set("pic"+i, strs[i]);
					}
					else
					{
						this.model.set("pic"+i, "http://7xl031.com1.z0.glb.clouddn.com/11.jpg");
					}
				}
			} else {
				picture = pic;
			}
			this.model.set("picture", picture);
		}
		this.$el.html(this.template(this.model.attributes));
		return this;
	}
});


$(function(){
	var roomDetail = new RoomDetail({'roomSeq':$("#roomSeq").val()});
	roomDetail.fetch();
	var roomDetailView = new RoomDetailView({model: roomDetail});
	
	
	
});