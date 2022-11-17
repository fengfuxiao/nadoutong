<!-- @format -->

<template>
  <div class="permission-manager">
    <ul>
      <li v-for="item in imgUrl" :key="item.id">
        <img v-lazy="item.url" alt="" />
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "PermissionManager",
  data() {
    return {
      // 图片列表
      imgUrl: [],
    };
  },
  mounted() {
    for (let i = 0; i < 10; i++) {
      this.imgUrl.push({
        id: i + 1,
        url: "https://s1.ax1x.com/2022/11/08/xxdQn1.jpg",
      });
    }
  },
};
</script>

<style lang="less">
.permission-manager {
  li {
    position: relative;
    margin-bottom: 10px;
  }
  img {
    display: inline-block;
    width: 200px;
    height: 300px;
  }
}
</style>
