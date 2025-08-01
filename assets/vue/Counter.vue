<script setup lang="ts">
import { ref } from "vue";
import { Button } from "@/components/ui/button";
import { Slider } from "@/components/ui/slider";

const props = defineProps<{ count: number }>();
const emit = defineEmits<{ inc: [{ value: number }] }>();
const diff = ref<number[]>([1]);
</script>

<template>
  Current count
  <div class="text-2xl text-bold">{{ props.count }}</div>
  <label class="block mt-8">Diff: </label>
  <Slider v-model="diff" class="mt-4" :min="1" :max="10" />

  <Button
    @click="emit('inc', { value: diff[0] })"
    class="mt-4 p-2 block"
  >
    Increase counter by {{ diff[0] }}
  </Button>
</template>
