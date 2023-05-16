<template>
  <div>
    <v-data-table
      v-bind="$attrs"
      :items="items"
      :options.sync="options"
      :server-items-length="totalCount"
      :loading="loading"
      @update:options="reload"
      @click:row="rowClick"
      item-key="id"
      :footer-props="{
        'items-per-page-options': [25, 50, 100],
      }"
      loading-text="Carregando... Por favor, aguarde!"
    >
      <template v-for="(index, name) in $scopedSlots" v-slot:[name]="data">
        <slot :name="name" v-bind="data"></slot>
      </template>
    </v-data-table>
  </div>
</template>


<script>
export default {
  props: {
    scope: { required: true },
  },
  data: () => ({
    items: [],
    filters: {},
    options: {},
    loading: false,
    totalCount: 0,
  }),
  methods: {
    reload() {
      this.loading = true;
      this.applyScope
        .all()
        .then((response) => {
          this.items = response.data;
          this.totalCount = response.meta.stats.total.count;
        })
        .finally(() => {
          this.loading = false;
        });
    },
    rowClick(item, options) {
      this.$emit("click:row", item, options);
    },
  },
  computed: {
    applyScope() {
      const { sortBy, sortDesc, page, itemsPerPage } = this.options;

      if (sortBy.length > 0) {
      }
      return this.scope
        .order(this.sortScope)
        .stats({ total: "count" })
        .page(page)
        .per(itemsPerPage);
    },
    sortScope() {
      const { sortBy, sortDesc } = this.options;
      let verso = sortBy.reduce((obj, e, i) => {
        obj[e] = sortDesc[i] ? "desc" : "asc";
        return obj;
      }, {});
      return verso;
    },
  },
  created() {
    console.log(this.$slots);
  },
};
</script>
