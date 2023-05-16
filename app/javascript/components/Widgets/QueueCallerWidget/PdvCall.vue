<template>
  <div class="content">
    <h3 class="text-center chama-senha-widget-text">
      Por favor, se dirija ao PDV
    </h3>

    <h1
      class="text-center chama-senha-widget-number chama-senha-widget-password"
    >
      {{ parseInt(pdvCall.number) }}
    </h1>
  </div>
</template>

<script>
export default {
  props: ["pdvCall"],
};
</script>

<style scoped>
.content {
  color: #fff;
}
.chama-senha-widget-password {
  font-size: 60vmin;
  font-weight: bolder;
  text-transform: uppercase;
}
.senha {
  font-size: 30vmin;
  font-weight: bolder;
  text-transform: uppercase;
  margin-top: -15px;
}

.chama-senha-widget-text {
  font-size: 12vmin;
}

.text {
  font-size: 18vmin;
  color: #ffffff;
  font-weight: bolder;
  text-transform: uppercase;
}
</style>