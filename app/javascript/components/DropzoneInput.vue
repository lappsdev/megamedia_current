<template>
  <vue-dropzone
    ref="myVueDropzone"
    id="dropzone"
    :options="dropzoneOptions"
    :useCustomSlot="true"
    @vdropzone-success="uploaded"
    @vdropzone-removed-file="removed"
  >
    <div class="dropzone-custom-content">
      <h3 class="dropzone-custom-title">Arraste e solte seus anexos aqui!</h3>
      <div class="subtitle">
        ... ou clique nesta caixa para selecionar manualmente.
      </div>
    </div>
  </vue-dropzone>
</template>

<script>
import vue2Dropzone from "vue2-dropzone";
import "vue2-dropzone/dist/vue2Dropzone.min.css";
import { Attachment } from "models/attachment.model";

export default {
  name: "DropzoneInput",
  components: {
    vueDropzone: vue2Dropzone,
  },
  data() {
    return {
      dropzoneOptions: {
        url: "/api/v1/attachments",
        thumbnailWidth: 150,
        maxFilesize: 800, // in MB
        timeout: 500000,
        addRemoveLinks: true,
        paramName: "attachment[file]",
        dictRemoveFile: "Remover",
        dictMaxFilesExceeded: "Quantidade máxima de anexos excedida!",
        dictCancelUpload: "Cancelar",
        dictInvalidFileType: "Arquivo inválido",
        dictFileTooBig: "O arquivo é grande demais!",
        headers: { Authorization: "Bearer " + localStorage.getItem("token") },
      },
      ids: [],
    };
  },
  methods: {
    uploaded(file, response) {
      this.ids.push(response.id);

      this.$emit("uploaded", { id: response.id });
      this.$emit("input", this.ids);
    },
    removed(file, error, xhr) {
      let id = JSON.parse(file.xhr.response).id;
      destroyAttachment(id).then((response) => {
        let index = this.ids.indexOf(id);
        this.ids.splice(index, 1);
        this.$emit("removed", { id });
        this.$emit("input", this.ids);
      });
    },
  },
};
</script>

<style scoped>
.dropzone-custom-title {
  margin-top: 0;
  color: #00b782;
}

.subtitle {
  color: #314b5f;
}
</style>