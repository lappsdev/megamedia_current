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
import { Unit } from "models/unit.model";

import { mapGetters } from "vuex";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: { type: Device, default: () => new Device() },
  },
  data() {
    return {
      valid: true,
      sending: false,
      units: [],
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.model
        .save({ with: "unit" })
        .then((success) => {
          if (success) {
            this.$emit("success", this.model);
            this.$refs.form.reset();
            this.model = new Device();
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
        unit: {
          type: "select",
          label: "Unidade",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.unit),
          itemText: "name",
          returnObject: true,
          items: this.units,
        },
        name: {
          type: "text",
          label: "Nome",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.name),
        },
        ip: {
          type: "text",
          label: "Endereço IP",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.ip),
        },
        mac: {
          type: "text",
          label: "Endereço MAC",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.mac),
        },
        notes: {
          type: "textarea",
          label: "Observações",
          prependIcon: "",
          rows: "2",
          ...this.errorsSchema(this.model.errors.notes),
        },
        sshSettings: {
          type: "group",
          label: "Configurações SSH",
          row: { dense: true },
          class: "title pb-2",
          schema: {
            host: {
              type: "text",
              label: "Host",
              prependIcon: "",
              col: 6,
            },
            user: {
              type: "text",
              label: "Usuário",
              prependIcon: "",
              col: 6,
            },
            password: {
              type: "password",
              label: "Senha",
              prependIcon: "",
              col: 6,
            },
            port: {
              type: "number",
              label: "Porta",
              prependIcon: "",
              col: 6,
            },
          },
        },
      };
    },
  },
  created() {
    Unit.all().then((response) => {
      this.units = response.data;
    });
  },
};
</script>
