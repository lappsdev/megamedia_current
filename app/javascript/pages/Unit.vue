<template>
  <v-card v-if="unit">
    <v-toolbar flat>
      <v-toolbar-title>Unidade {{ unit.name }}</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-btn icon>
        <v-icon>mdi-dots-vertical</v-icon>
      </v-btn>

      <template v-slot:extension>
        <v-tabs v-model="tab" align-with-title>
          <v-tabs-slider color="yellow"></v-tabs-slider>

          <v-tab key="general">Geral</v-tab>
          <v-tab key="medias">Equipamentos</v-tab>
          <v-tabs-items v-model="tab">
            <v-tab-item key="general">
              <v-card flat>
                <v-card-text>
                  <unit-form :model="unit" @success="onEdit"></unit-form>

                  <v-divider></v-divider>
                </v-card-text>
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-tabs>
      </template>
    </v-toolbar>
  </v-card>
</template>

<script>
import { Unit } from "models/unit.model";
import UnitForm from "components/Units/Form";
export default {
  props: {
    id: { required: true },
  },
  components: {
    UnitForm,
  },
  data() {
    return {
      unit: null,
      tab: null,
    };
  },
  methods: {
    onEdit() {
      this.$toast.success("Editada com sucesso!");
    },
  },
  created() {
    Unit.includes(["devices"])
      .find(this.id)
      .then((response) => {
        this.unit = response.data;
      });
  },
};
</script>

<style>
</style>