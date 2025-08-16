<script setup lang="ts">
import { GalleryVerticalEnd } from "lucide-vue-next";
import { Link } from "live_vue";
import LoginForm from "@/components/log-in/LoginForm.vue";

const URL = import.meta.env.VITE_PHOENIX_URL;
</script>

<template>
  <div class="grid min-h-svh lg:grid-cols-2">
    <div class="flex flex-col gap-4 p-6 md:p-10">
      <div class="flex justify-center gap-2 md:justify-start">
        <Link navigate="/" class="flex items-center gap-2 font-medium">
          <div
            class="flex h-6 w-6 items-center justify-center rounded-md bg-primary text-primary-foreground"
          >
            <GalleryVerticalEnd class="size-4" />
          </div>
          Katana is your place
        </Link>
      </div>
      <div class="flex flex-1 items-center justify-center">
        <div class="w-full max-w-xs">
          <LoginForm />
        </div>
      </div>
    </div>
    <div class="relative hidden bg-muted lg:block">
      <img
        :src="`${URL}/images/placeholder.svg`"
        class="absolute inset-0 h-full w-full object-cover"
      />
    </div>
  </div>
</template>
