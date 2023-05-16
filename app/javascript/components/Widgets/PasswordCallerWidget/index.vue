<template>
  <v-row v-hotkey="keymap" class="fill-height justify-center align-center">
    <v-col cols="12">
      <div class="content text-center" style="line-height: 19vmin">
        <span class="medium-responsive-text title-txt">Senha atual</span>

        <h1 class="big-responsive-text red--text text--darken-4">
          {{ currentPassword }}
        </h1>
      </div>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      currentPassword: 1,
      calling: false,
      buffer: "",
    };
  },
  methods: {
    setPassword(number) {
      if (!this.calling) {
        this.calling = true;
        this.currentPassword = number;
        let file = require(`sounds/dingdong.mp3`);
        let audio = new Audio(file);
        audio.addEventListener("ended", () => {
          this.calling = false;
        });
        audio.play();
      }
    },
    incrementPassword() {
      this.setPassword(this.currentPassword + 1);
    },
    decrementPassword() {
      this.setPassword(this.currentPassword - 1);
    },
    addToBuffer: function (event) {
      let n = event.key;
      if (!isNaN(parseFloat(n)) && isFinite(n)) {
        this.buffer += n;
      }
    },
    commitBuffer() {
      let newPass = parseInt(this.buffer);
      if (newPass && !isNaN(parseFloat(newPass)) && isFinite(newPass)) {
        this.setPassword(newPass);
      }
      this.buffer = "";
    },
  },
  computed: {
    keymap() {
      return {
        plus: this.incrementPassword,
        "numpad -": this.decrementPassword,
        enter: this.commitBuffer,
      };
    },
  },
  mounted() {
    window.addEventListener("keydown", this.addToBuffer);
  },
};
</script>

<style scoped>
.big-responsive-text {
  font-size: 28vmin;
}
.small-responsive-text {
  font-size: 5vmin;
}
.medium-responsive-text {
  font-size: 10vmin;
}
.normal-responsive-text {
  font-size: 10vmin;
}
</style>