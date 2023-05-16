<template>
  <v-row v-if="product" justify="center" align="center">
    <v-col cols="12">
      <h1
        class="text-center text-uppercase text-h4 text-md-h2 font-weight-bold mb-5"
      >
        {{ product.description }}
      </h1>
    </v-col>
    <v-col v-for="obj in priceObjects" :key="obj.title" :cols="numCols">
      <div class="text-center">
        <v-card v-bind="obj.cardProps">
          <v-card-title class="pb-0 text-center justify-center">
            <h1 class="text-uppercase title font-weight-light">
              {{ obj.title }}
            </h1>
          </v-card-title>
          <v-card-text>
            <span class="font-weight-bold"
              ><span class="text-h6">R$</span>
              <span :class="`text-h3 text-sm-h2 text-md-h1 font-weight-bold`">{{
                obj.value
              }}</span></span
            ></v-card-text
          >
        </v-card>
      </div>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    product: {
      type: Object,
      required: true,
    },
    styles: {
      type: Object,
      required: false,
    },
  },
  computed: {
    priceObjects() {
      let objs = [{ title: "Preço", value: this.product.price }];
      if (this.product.promotionalPrice > 0.0) {
        objs.push({
          title: "Preço Clube Paraná",
          value: this.product.promotionalPrice,
        });
      }
      if (this.product.fatorPromotionalPrice > 0.0) {
        objs.push({
          title: `A partir de ${this.product.fatorPromotional} unidades`,
          value: this.product.fatorPromotionalPrice,
        });
      }
      return objs;
    },
    numCols() {
      let cols = 1;
      if (this.product.promotionalPrice > 0.0) {
        cols++;
      }
      if (this.product.fatorPromotionalPrice > 0.0) {
        cols++;
      }
      return 12 / cols;
    },
  },
};
</script>

<style>
</style>