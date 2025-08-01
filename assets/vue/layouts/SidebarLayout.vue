<template>
  <SidebarProvider :default-open="true">
    <UserSidebar />
    <SidebarInset>
      <header class="flex h-16 shrink-0 items-center gap-2 border-b px-4">
        <SidebarTrigger class="-ml-1" />
        <Separator orientation="vertical" class="mr-2 h-4" />
        <div class="text-sm font-medium">
          {{ pageTitle || "CoderDojo Braga" }}
        </div>
      </header>
      <div class="flex flex-1 flex-col gap-4 p-4">
        <slot />
      </div>
    </SidebarInset>
  </SidebarProvider>
</template>

<script setup lang="ts">
import { Separator } from "@/components/ui/separator";
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "@/components/ui/sidebar";

import UserSidebar from "@/components/core/UserSidebar.vue";

interface Props {
  pageTitle?: string;
}

defineProps<Props>();
</script>
