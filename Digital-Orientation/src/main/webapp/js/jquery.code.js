/**
 * Created by duanhailin on 2018/06/21.
 */
;(function ($) {
  function createCode(dom, config) {
    var _this = this;
    _this.config = config
    _this.codeList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    _this.color = ['#e30d65', '#3c8b36', '#74675a', '#654321','#123345', '#135784', '#169b9a', '#02468a'];
    _this.bgColorList = ['#D1EEEE'];
    _this.bgColor = '';
    _this.code = '';
    if (_this.config) {
      _this.codeLen = _this.config.len || 4;
    } else {
      _this.codeLen = 4;
    }
    var html = '';
    var deg = 0;
    for (i = 0; i < _this.codeLen; i++) {
      var index = Math.floor(Math.random() * _this.codeList.length);
      var idx = Math.floor(Math.random() * _this.color.length);
      var bgIdx = Math.floor(Math.random() * _this.bgColorList.length);
      if (index % 2 == 0) {
        deg = index + Math.floor(Math.random() * idx)
      } else {
        deg = -(index + Math.floor(Math.random() * idx))
      }
      html += '<span style="padding:0 2px;color:' + _this.color[idx] + ';display:inline-block;transform:rotate(' + deg + 'deg);">' + _this.codeList[index] + '</span>';
      _this.code += _this.codeList[index];
      _this.bgColor = _this.bgColorList[bgIdx]

    }
    html += '<input placeholder="" value="'+_this.code+'" type="hidden">';
    $(dom).css({
      width: _this.codeLen * 20 + 'px',
      padding: '1px',
      textAlign: 'center',
      display: 'inline-block',
      backgroundColor: _this.bgColor,
      cursor: "pointer",
      opacity: .6
    });
    $(dom).empty().append(html);
  }

  $.fn.createCode = function (cfg) {
    var _this = this;
    createCode(_this, cfg);
    $(_this).click(function () {
      createCode(_this, cfg);
    });
  }
})(jQuery);