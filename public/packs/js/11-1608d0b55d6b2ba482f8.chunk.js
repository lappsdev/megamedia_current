(window.webpackJsonp=window.webpackJsonp||[]).push([[11],{144:function(t,e,r){"use strict";r.r(e);var o={props:{product:{type:Object,required:!0},styles:{type:Object,required:!1}},computed:{priceObjects:function(){var t=[{title:"Pre\xe7o",value:this.product.price}];return this.product.promotionalPrice>0&&t.push({title:"Pre\xe7o Clube Paran\xe1",value:this.product.promotionalPrice}),this.product.fatorPromotionalPrice>0&&t.push({title:"A partir de ".concat(this.product.fatorPromotional," unidades"),value:this.product.fatorPromotionalPrice}),t},numCols:function(){var t=1;return this.product.promotionalPrice>0&&t++,this.product.fatorPromotionalPrice>0&&t++,12/t}}},s=r(7),c=Object(s.a)(o,(function(){var t=this,e=t.$createElement,r=t._self._c||e;return t.product?r("v-row",{attrs:{justify:"center",align:"center"}},[r("v-col",{attrs:{cols:"12"}},[r("h1",{staticClass:"text-center text-uppercase text-h4 text-md-h2 font-weight-bold mb-5"},[t._v("\n      "+t._s(t.product.description)+"\n    ")])]),t._v(" "),t._l(t.priceObjects,(function(e){return r("v-col",{key:e.title,attrs:{cols:t.numCols}},[r("div",{staticClass:"text-center"},[r("v-card",t._b({},"v-card",e.cardProps,!1),[r("v-card-title",{staticClass:"pb-0 text-center justify-center"},[r("h1",{staticClass:"text-uppercase title font-weight-light"},[t._v("\n            "+t._s(e.title)+"\n          ")])]),t._v(" "),r("v-card-text",[r("span",{staticClass:"font-weight-bold"},[r("span",{staticClass:"text-h6"},[t._v("R$")]),t._v(" "),r("span",{class:"text-h3 text-sm-h2 text-md-h1 font-weight-bold"},[t._v(t._s(e.value))])])])],1)],1)])}))],2):t._e()}),[],!1,null,null,null);e.default=c.exports}}]);
//# sourceMappingURL=11-1608d0b55d6b2ba482f8.chunk.js.map