<template>
  <v-form @submit.prevent="submit" v-model="valid" autocomplete="off">
    <v-row>
      <v-col cols="12">
        <v-form-base :col="{ cols: 12 }" :model="credential" :schema="schema" />
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
          >Acessar</v-btn
        >
      </v-col>
    </v-row>
  </v-form>
</template>

<script>
import VFormBase from "vuetify-form-base";

import { Credential } from "models/credential.model";
export default {
  components: {
    VFormBase,
  },
  data() {
    return {
      valid: true,
      sending: false,
      credential: new Credential(),
    };
  },
  methods: {
    submit() {
      this.sending = true;
      this.credential
        .save({ returnScope: Credential.includes(["user", { user: "group" }]) })
        .then((success) => {
          if (success) {
            this.$emit("success", this.credential);
          }
        })
        .finally(() => {
          this.sending = false;
        });
    },
  },
  computed: {
    schema() {
      return {
        login: {
          type: "text",
          label: "Login",
          prependIcon: "",
          error: this.credential.errors.login != null,
          "error-messages": this.credential.errors.login
            ? [this.credential.errors.login.message]
            : null,
          "error-count": this.credential.errors.login
            ? this.credential.errors.login.message.length
            : null,
        },
        password: {
          type: "password",
          label: "Senha",
          prependIcon: "",
          error: this.credential.errors.password != null,
          "error-messages": this.credential.errors.password
            ? [this.credential.errors.password.message]
            : null,
          "error-count": this.credential.errors.password
            ? this.credential.errors.password.message.length
            : null,
        },
      };
    },
  },
};
</script>

<style>
</style>