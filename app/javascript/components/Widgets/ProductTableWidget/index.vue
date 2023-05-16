<template>
  <div style="width: 100%; height: 100%">
    <v-simple-table class="text-uppercase text-center table-striped table-psm">
      <template v-slot:default>
        <thead class="red darken-3">
          <tr class="">
            <th class="text-center white--text">Código</th>
            <th class="text-center white--text">Descrição</th>
            <th class="text-center white--text">Preço</th>
            <th class="text-center white--text blue">Preço Clube</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in products" :key="item.id">
            <td>{{ item.balanceCode }}</td>
            <td>{{ item.description }}</td>

            <td>
              {{
                item.price.toLocaleString("pt-BR", {
                  style: "currency",
                  currency: "BRL",
                })
              }}
            </td>
            <td>
              <span v-if="item.promotionalPrice > 0">
                {{
                  item.promotionalPrice.toLocaleString("pt-BR", {
                    style: "currency",
                    currency: "BRL",
                  })
                }}
              </span>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </div>
</template>

<script>
import { ProductTableWidget } from "models";
export default {
  props: {
    widget: { type: ProductTableWidget, required: true },
  },
  data() {
    return {
      products: [],
    };
  },
  created() {
    this.widget.products().then((products) => {
      this.products.push(...products);
    });
  },
  computed: {
    file() {
      return this.widget.attachment.file;
    },
  },
};
</script>

<style scoped>
.table-psm tr td {
  font-size: 1.1vmax !important;
  font-weight: bold;
}
.table-psm thead tr th {
  font-size: 0.9vmax !important;
  font-weight: bold;
}

.table-striped tbody > tr:nth-child(2n + 1) {
  background-color: rgba(255, 0, 0, 0.2) !important;
}
</style>