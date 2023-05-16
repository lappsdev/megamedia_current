<template>
  <div>
    <v-main>
      <v-container class="py-8 px-6" fluid>
        <v-row>
          <v-col cols="12">
            <v-card class="mx-auto" max-width="600px">
              <v-toolbar flat>
                <v-toolbar-title class="grey--text">
                  Autentique-se
                </v-toolbar-title>
              </v-toolbar>

              <v-divider></v-divider>

              <v-card-text>
                <Form @success="onLogin"></Form>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { User } from "models/user.model";
import { Group } from "models/group.model";

import Form from "components/Login/Form";
export default {
  components: {
    Form,
  },
  methods: {
    ...mapMutations(["SET_CURRENT_USER", "SET_TOKEN"]),

    onLogin(credential) {
      console.log(credential);
      this.$toast.success("Acesso autorizado. Seja bem vindo!");
      this.SET_CURRENT_USER(credential.user);
      localStorage.setItem("token", credential.jsonWebToken);
      this.$router.push("/admin/dashboard");
    },
  },
};
</script>

<style>
</style>