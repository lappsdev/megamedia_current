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
import { Attachment } from "models/attachment.model";
export default {
  components: {
    VFormBase,
  },
  props: {
    model: {
      type: Attachment,
      default: () => new Attachment({ group: Group.current() }),
    },
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
            this.$refs.form.reset();
            this.model = new Attachment();
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
        name: {
          type: "text",
          label: "Nome",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.name),
        },
        description: {
          type: "text",
          label: "Descrição",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.description),
        },
        expiredAt: {
          type: "datetime-picker",
          label: "Expira em",
          prependIcon: "",
          ...this.errorsSchema(this.model.errors.expiredAt),
        },
      };
    },
  },
};
</script>
