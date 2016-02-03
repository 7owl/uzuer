function pagecancel() {
	// parent.window.close();
	parent.$('#w_image').window('close');
}

$(document).ready(function() {

	// 点击图片
	$('img').click(function() {
		if($(this).next().attr('sort')=='0')
		$('#myModalLabel').html($(this).attr('name')+'（首选图片）');
		else
		$('#myModalLabel').html($(this).attr('name'));	
		// + ' <small>' + $(this).val() + '</small>'
		$('#modal-content').html('<img class=\'img-responsive\' src=\''
				+ $(this).attr('src') + '\'/>');
		$('#myModal').modal('show');;
		return;
	});

	// 点击上传
	$('#upload').click(function() {
		if ($('#image_name').val() == '' || $('#image').val() == '') {

		} else {
			$('#form').attr('action', 'uploadImage');
			$('#form').attr('enctype', 'multipart/form-data');
			$('#form').attr('method', 'post');
			$('#form').submit();

		}
	});
	// 点击确定退出
	$('#exit').click(function() {
		// location.href='viewRoom';
		// this.parent.parent.window("close");
	});
	// 点击确定删除图片
	$('#delete').click(function() {
		var ids = "";
		var urls = [];
		var i = 0;
		$('input[type=checkbox]:checked').each(function() {
			/*ids += $(this).val() + ',';
			i++;*/
			var url = $(this).attr('url');
			if( _.isString(url) ){
				var start = url.lastIndexOf('/');
				var end = url.indexOf('.thumb');
				if(start+1 < end){
					urls.push( url.substring(start+1, end) );
					i++;
				}
			}
				
		});
		if (i <= 0) {
			alert('您没有选择要删除的图片');
			$('#myModa3').modal('hide');
			return;
		}
		//alert(urls.join(","));
		ids = urls.join(',');
		$.post('delImage', {
			delIds : ids
		}, function(data, status) {
			parent.$.messager.alert('警告', data.success, 'info');
			$('#myModa3').modal('hide');
			location.href = 'fileUpView?id='
					+ $("#room_id_pic").val();
		});
	});
	var dragSrcEl;// 被拖拽的对象
	var dropTarEl;// 被放的对象
	var datas = [];
	$(".imgDrag").each(function(index) {
				this.addEventListener('dragstart', function(e) {
					dragSrcEl = this;
					console.log(e);
					e.dataTransfer.effectAllowed = 'all';
					e.dataTransfer.setData('text/html', this.innerHTML);
					this.style.border = "1px solid red";
				});

				this.addEventListener('dragenter', function(e) {
					return false;
				});

				this.addEventListener('dragover', function(e) {
					if (e.preventDefault) {
						e.preventDefault();
					}
					e.dataTransfer.dropEffect = 'move';
				});

				this.addEventListener('drop', function(e) {
					dropTarEl = this;
					datas = [];
					var src = {
						id : "",
						picname : ""
					};
					var target = {
						id : "",
						picname : ""
					};
					if (e.stopPropagation) {
						e.stopPropagation();
					}
					if (e.preventDefault) {
						e.preventDefault();
					}
					if (dragSrcEl != this) {
						setImageObject($(this), target, $(dragSrcEl));
						setImageObject($(dragSrcEl), src, $(this));
						datas.push(src);
						datas.push(target);
						//console.log(datas);
						var tmp = dragSrcEl.innerHTML;
						dragSrcEl.innerHTML = this.innerHTML;
						this.innerHTML = tmp;

						this.style.border = '';
						dragSrcEl.style.border = '';
						

						// 点击图片
						$(this).find('img').click(function() {
							if($(this).next().attr('sort')=='0')
							$('#myModalLabel').html($(this).attr('name')+'（首选图片）');
							else
							$('#myModalLabel').html($(this).attr('name'));	
							// + ' <small>' + $(this).val() + '</small>'
							$('#modal-content').html('<img class=\'img-responsive\' src=\''
									+ $(this).attr('src') + '\'/>');
							$('#myModal').modal('show');;
							return;
						});
						$(dragSrcEl).find('img').click(function() {
							if($(this).next().attr('sort')=='0')
							$('#myModalLabel').html($(this).attr('name')+'（首选图片）');
							else
							$('#myModalLabel').html($(this).attr('name'));	
							// + ' <small>' + $(this).val() + '</small>'
							$('#modal-content').html('<img class=\'img-responsive\' src=\''
									+ $(this).attr('src') + '\'/>');
							$('#myModal').modal('show');;
							return;
						});
						$.post('updateImageSort', {
							images : JSON.stringify({
								datas : datas
							})
						}, function(data, status) {
							if (data.code == "0") {
								if($(dragSrcEl).find("input").attr("sort")==0){
									
								$(dragSrcEl).find('img').attr('name',target.picname);
								$(dropTarEl).find("img").attr( "name", src.picname );
								$(dragSrcEl).find("input").attr( "sort", target.picname );
								$(dropTarEl).find("input").attr( "sort", src.picname );
								
								$(dragSrcEl).find("a span").text( target.picname );
								$(dropTarEl).find("a span").text( src.picname+'(首选)' );
								}
							else{
								$(dragSrcEl).find('img').attr('name',target.picname);
								$(dropTarEl).find("img").attr( "name", src.picname );
								$(dragSrcEl).find("input").attr( "sort", target.picname );
								$(dropTarEl).find("input").attr( "sort", src.picname );
								
								$(dragSrcEl).find("a span").text( target.picname );
								$(dropTarEl).find("a span").text( src.picname );
									}
								//location.reload();
							}
						});
					}
					return false;
				});

				this.addEventListener('dragend', function(e) {
					return false;
				});
						
		});
});



function setImageObject(imgObj, obj, swapObj) {
	var max = $(".imgDrag").length;
	obj.id = imgObj.find("input").val();
	var tempsort =Number(swapObj.find("input").attr("sort"));
	if(tempsort<10)
	obj.picname = pad(Number(swapObj.find("input").attr("sort")), 1);
	else
	obj.picname = pad(Number(swapObj.find("input").attr("sort")), (max + "").length);
	//console.log( imgObj.html() );
	//console.log( obj.id + ":" + obj.picname );
}

function pad(num, n) {
	return Array(n > num ? (n - ('' + num).length + 1) : 0).join(0) + num;
}
