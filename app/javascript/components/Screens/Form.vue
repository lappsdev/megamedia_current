<template>
  <v-form ref="form" @submit="submit" v-model="valid" autocomplete="off">
    <v-row>
      <v-col cols="12">
        <v-form-base :col="{ cols: 12 }" :model="model" :schema="schema" />
      </v-col>
      <v-col cols="12">
        <v-btn
          color="#00CC5B"
          class="button white--text"
          type="submit"
          :loading="sending"
          :disabled="sending"
          block
          large
          >Finalizar</v-btn
        >
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
import VFormBase from "vuetify-form-base";
import { Device } from "models/device.model";
import { Screen } from "models/screen.model";
import { Group } from "models/group.model";

import { mapGetters } from "vuex";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: {
      type: Screen,
      default: () => new Screen({ group: Group.current() }),
    },
  },
  data() {
    return {
      valid: true,
      sending: false,
      devices: [],
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.model
        .save({ with: ["device", "group"] })
        .then((success) => {
          if (success) {
            this.$emit("success", this.model);
            this.$refs.form.reset();
            this.model = new Screen({ group: Group.current() });
          }
        })
        .catch((err) => console.log(err))
        .finally(() => {
          this.sending = false;
        });
    },
    errorsSchema(errorAttr) {
      return {
        error: errorAttr != null,
        "error-messages": errorAttr ? [errorAttr.message] : null,
        "error-count": errorAttr ? 1 : null,
      };
    },
  },

  computed: {
    possibleUnits() {
      Unit.all();
    },
    schema() {
      return {
        device: {
          type: "select",
          label: "Equipamento",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.device),
          itemText: "name",
          returnObject: true,
          items: this.devices,
        },
        name: {
          type: "text",
          label: "Nome",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.name),
        },
      };
    },
  },
  created() {
    Device.per(500)
      .all()
      .then((response) => {
        this.devices = response.data;
      });
  },
};
</script>
