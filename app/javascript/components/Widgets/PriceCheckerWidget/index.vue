<template>
  <v-row class="fill-height justify-center align-center">
    <v-col cols="12">
      <component
        :is="currentComponent"
        :product="currentProduct"
        :widget="widget"
      ></component>
    </v-col>
  </v-row>
</template>
<script>
import Idle from "./Idle";
import BarcodeNotFound from "./BarcodeNotFound";
import ProductInfo from "./ProductInfo";
import { PriceCheckerWidget } from "models/price_checker_widget.model";
import { Product } from "models/product.model";

export default {
  props: {
    widget: { type: PriceCheckerWidget, required: true },
  },
  components: { Idle, BarcodeNotFound, ProductInfo },
  data: () => ({
    component: Idle,
    currentProduct: null,
  }),
  created() {
    this.$barcodeScanner.init(this.onBarcodeScanned);
  },
  destroyed() {
    this.$barcodeScanner.destroy();
  },
  methods: {
    onBarcodeScanned(barcode) {
      if (!this.currentProduct) {
        this.widget.scan(barcode).then((product) => {
          this.currentProduct = product;
          setTimeout(() => {
            this.currentProduct = null;
          }, 3000);
        });
      }
    },
    resetBarcode() {
      let barcode = this.$barcodeScanner.getPreviousCode();
    },
  },
  computed: {
    currentComponent() {
      if (this.currentProduct) {
        if (this.currentProduct instanceof Product) {
          return ProductInfo;
        } else {
          return BarcodeNotFound;
        }
      } else {
        return Idle;
      }
    },
  },
};
</script>

