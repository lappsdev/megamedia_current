<template>
  <v-form ref="form" @submit="submit" v-model="valid" autocomplete="off">
    <v-row v-if="formSchema">
      <v-col cols="12">
        <v-form-base :col="{ cols: 12 }" :model="model" :schema="formSchema" />
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

import { mapGetters } from "vuex";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: { required: true },
    schema: { type: [Promise, Object], required: true },
    save: { type: Function, required: false },
  },
  data() {
    return {
      valid: true,
      sending: false,
      formSchema: null,
    };
  },
  methods: {
    saveFunction() {
      let func = this.save ? this.save : this.model.save;
      return func();
    },

    submit() {
      this.saveFunction()
        .then((success) => {
          if (success) {
            this.$emit("success", this.model);
          }
        })
        .catch((err) => {
          console.log(err);
          this.$emit("error", this.model);
        })
        .finally(() => {
          this.sending = false;
        });
    },
  },

  created() {
    if (this.schema instanceof Promise) {
      this.schema.then((schema) => {
        this.formSchema = schema;
      });
    } else if (this.schema instanceof Object) {
      this.formSchema = this.schema;
    }
  },
};
</script>
