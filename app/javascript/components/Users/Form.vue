

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
import { Group } from "models/group.model";
import { User } from "models/user.model";

import { mapGetters } from "vuex";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: {
      type: User,
      default: () => new User({ group: Group.current(), role: "marketing" }),
    },
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
        .save({ with: "group" })
        .then((success) => {
          if (success) {
            this.$emit("success", this.model);
            this.$refs.form.reset();
            this.model = new User();
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
    schema() {
      return {
        role: {
          type: "select",
          label: "Tipo de usuário",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.role),
          itemText: "text",
          itemValue: "value",
          items: [
            { text: "Administrador", value: "admin" },
            { text: "Marketing", value: "marketing" },
          ],
          required: true,
        },
        name: {
          type: "text",
          label: "Nome",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.name),
        },
        login: {
          type: "text",
          label: "Login",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.login),
        },
        password: {
          type: "password",
          label: "Senha",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.password),
        },
      };
    },
  },
};
</script>
