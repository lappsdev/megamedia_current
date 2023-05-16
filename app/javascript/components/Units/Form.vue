<template>
  <v-form ref="form" v-model="valid" autocomplete="off">
    <v-row>
      <v-col cols="12">
        <v-form-base :col="{ cols: 12 }" :model="model" :schema="schema" />
      </v-col>
      <v-col cols="12">
        <v-btn
          color="#00CC5B"
          class="button white--text"
          :loading="sending"
          :disabled="sending"
          block
          large
          @click="submit"
          >Finalizar</v-btn
        >
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
import VFormBase from "vuetify-form-base";
import { Unit } from "models/unit.model";
import { Group } from "models/group.model";

import { mapGetters } from "vuex";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: { type: Unit, default: () => new Unit({ group: Group.current() }) },
  },
  data() {
    return {
      valid: true,
      sending: false,
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.model
        .save({ with: "group" })
        .then((success) => {
          if (success) {
            this.$emit("success", this.model);
            //            this.$refs.form.reset();
            // this.model = new Unit();
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
    ...mapGetters(["currentGroup"]),
    schema() {
      return {
        name: {
          type: "text",
          label: "Nome",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.name),
        },
        wrpdvSettings: {
          type: "group",
          label: "Configurações WRPDV",
          class: "title pb-2",

          schema: {
            pdvlivre_path: {
              type: "text",
              label: "URL completa do PDVLivre",
              prependIcon: "",
            },
          },
        },
        flexSettings: {
          type: "group",
          label: "Configurações FLEX",
          row: { dense: true },
          class: "title pb-2",
          schema: {
            db_host: {
              type: "text",
              label: "Host",
              prependIcon: "",
              col: 6,
            },
            db_port: {
              type: "text",
              label: "Porta",
              prependIcon: "",
              col: 6,
            },
            db_user: {
              type: "text",
              label: "Usuário",
              prependIcon: "",
              col: 6,
            },
            db_password: {
              type: "password",
              label: "Senha",
              prependIcon: "",
              col: 6,
            },
            db_name: {
              type: "text",
              label: "Nome do banco",
              prependIcon: "",
              col: 6,
            },
            unit_code: {
              type: "text",
              label: "Código da unidade",
              prependIcon: "",
              col: 6,
            },
          },
        },
      };
    },
  },
};
</script>
