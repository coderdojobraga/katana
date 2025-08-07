<script setup lang="ts">
import type { HTMLAttributes } from "vue";
import { cn } from "@/lib/utils";

const props = defineProps<{
  show?: boolean;
  message?: string;
  class?: HTMLAttributes["class"];
}>();
</script>

<template>
  <div
    v-if="show && message"
    :class="cn('text-sm text-destructive', props.class)"
  >
    {{ message }}
  </div>
</template>
