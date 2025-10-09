<script setup lang="ts">
import { Ref, ref } from "vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link } from "live_vue";

const form: Ref<{ email: string }> = ref({
  email: "",
});
</script>

<template>
  <form class="flex flex-col gap-6">
    <div class="flex flex-col items-center gap-2 text-center">
      <h1 class="text-2xl font-bold">Esqueceu-se da sua palavra-passe?</h1>
      <p class="text-muted-foreground text-sm">
        Introduza o endereço de email associado à sua conta e enviaremos um
        link para redefinir a sua palavra-passe
      </p>
    </div>
    <div class="grid gap-6">
      <div class="grid gap-3">
        <Label for="email">Email</Label>
        <Input
          id="email"
          type="email"
          placeholder="mail@coderdojobraga.org"
          v-model="form.email"
          required
        />
      </div>
      <Button
        type="button"
        @click="$live.pushEvent('send_email', { user: { email: form.email } })"
        :disabled="!form.email"
        class="w-full"
      >
        Enviar link de redefinição
      </Button>
    </div>
    <div class="text-center text-sm">
      Lembra-se da sua palavra-passe?
      <Link navigate="/users/log_in" class="underline underline-offset-4">
        Iniciar sessão
      </Link>
    </div>
  </form>
</template>
