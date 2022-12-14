import Vue from 'vue'
import App from './App.vue'
import router from "./router/index"
import store from "./store/index"
import "./plugin/element"
import "font-awesome/css/font-awesome.min.css"
import ECharts from 'vue-echarts'
import "echarts";
import VueLazyload from "vue-lazyload"


Vue.config.productionTip = false
// 全局注册组件（也可以使用局部注册）
Vue.component('v-chart', ECharts)

// 图片懒加载插件
Vue.use(VueLazyload, {
  preLoad: 1.3,
  error: "https://s1.ax1x.com/2022/11/08/xxBUc4.jpg",
  loading: "https://s1.ax1x.com/2022/11/08/xxBUc4.jpg",
  attempt: 1,
  throttleWait: 500
})

new Vue({
  render: h => h(App),
  router,
  store,
}).$mount('#app')