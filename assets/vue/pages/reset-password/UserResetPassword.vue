<script setup lang="ts">
import { GalleryVerticalEnd } from "lucide-vue-next";
import { Link } from "live_vue";
import ResetPasswordForm from "@/components/reset-password/ResetPasswordForm.vue";

const props = defineProps<{
  form: any;
}>();
</script>

<template>
  <div class="min-h-svh flex items-center justify-center p-6">
    <div class="w-full max-w-md space-y-8">
      <div class="flex justify-center">
        <Link navigate="/" class="flex items-center gap-2 font-medium">
          <div
            class="flex h-8 w-8 items-center justify-center rounded-md bg-primary text-primary-foreground"
          >
            <GalleryVerticalEnd class="size-5" />
          </div>
          Katana
        </Link>
      </div>
      <ResetPasswordForm :form="props.form" />
    </div>
  </div>
</template>
