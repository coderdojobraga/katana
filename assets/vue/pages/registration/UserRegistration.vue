<script setup lang="ts">
import { GalleryVerticalEnd } from "lucide-vue-next";
import RegistrationForm from "@/components/registration/RegistrationForm.vue";

const props = defineProps<{
  form: any;
}>();

const URL = import.meta.env.VITE_PHOENIX_URL;
</script>

<template>
  <div class="grid min-h-svh lg:grid-cols-2">
    <div class="relative hidden bg-muted lg:block">
      <img
        :src="`${URL}/images/placeholder.svg`"
        class="absolute inset-0 h-full w-full object-cover"
      />
    </div>
    <div class="flex flex-col gap-4 p-6 md:p-10">
      <div class="flex justify-center gap-2 md:justify-start">
        <a href="#" class="flex items-center gap-2 font-medium">
          <div
            class="flex h-6 w-6 items-center justify-center rounded-md bg-primary text-primary-foreground"
          >
            <GalleryVerticalEnd class="size-4" />
          </div>
          Welcome to Katana
        </a>
      </div>
      <div class="flex flex-1 items-center justify-center">
        <div class="w-full max-w-xs">
          <RegistrationForm :form="props.form" />
        </div>
      </div>
    </div>
  </div>
</template>
