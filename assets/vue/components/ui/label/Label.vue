<script setup lang="ts">
import type { LabelProps } from "reka-ui";
import type { HTMLAttributes } from "vue";
import { reactiveOmit } from "@vueuse/core";
import { Label } from "reka-ui";
import { cn } from "@/lib/utils";

const props = defineProps<
  LabelProps & {
    class?: HTMLAttributes["class"];
    mandatory?: boolean;
    annotation?: string;
  }
>();

const delegatedProps = reactiveOmit(props, "class", "mandatory", "annotation");
</script>

<template>
  <div class="flex flex-col gap-1">
    <Label
      data-slot="label"
      v-bind="delegatedProps"
      :class="
        cn(
          'flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50',
          props.class,
        )
      "
    >
      <slot />
      <span v-if="mandatory" class="text-destructive">*</span>
    </Label>
    <p v-if="annotation" class="text-xs text-muted-foreground">
      {{ annotation }}
    </p>
  </div>
</template>
