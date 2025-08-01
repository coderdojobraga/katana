<script setup lang="ts">
import type { SidebarProps } from "@/components/ui/sidebar";

import { Baby, Calendar1, House } from "lucide-vue-next";
import NavMain from "@/components/core/NavMain.vue";
import NavUser from "@/components/core/NavUser.vue";

import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarRail,
} from "@/components/ui/sidebar";

const props = withDefaults(defineProps<SidebarProps>(), {
  collapsible: "icon",
});

const data = {
  user: {
    name: "Rui Lopes",
    email: "mail@ruilopesm.com",
    avatar: "/images/ruilopes.jpg",
  },
  navMain: [
    {
      title: "Home",
      url: "/",
      icon: House,
      isActive: true,
    },
    {
      title: "Events",
      url: "/events",
      icon: Calendar1,
      items: [
        {
          title: "All",
          url: "?filter=all",
        },
        {
          title: "Upcoming",
          url: "?filter=upcoming",
        },
      ],
    },
    {
      title: "Ninjas",
      url: "/ninjas",
      icon: Baby,
      items: [
        {
          title: "Settings",
          url: "/settings",
        },
        {
          title: "Curriculum",
          url: "/curriculum",
        },
        {
          title: "Materials",
          url: "/materials",
        },
      ],
    },
  ],
};
</script>

<template>
  <Sidebar v-bind="props">
    <SidebarContent>
      <NavMain :items="data.navMain" />
    </SidebarContent>
    <SidebarFooter>
      <NavUser :user="data.user" />
    </SidebarFooter>
    <SidebarRail />
  </Sidebar>
</template>
