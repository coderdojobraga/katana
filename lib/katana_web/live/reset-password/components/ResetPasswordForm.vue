<script setup lang="ts">
import { type Form, Link, useLiveForm } from "live_vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { FieldError } from "@/components/ui/field-error";

const props = defineProps<{
  form: Form<ResetPasswordFields>;
}>();

const form = useLiveForm(() => props.form, {
  changeEvent: "validate",
  submitEvent: "reset_password",
});

const passwordField = form.field("password");
const passwordConfirmationField = form.field("password_confirmation");
</script>

<template>
  <form class="flex flex-col gap-6">
    <div class="flex flex-col items-center gap-2 text-center">
      <h1 class="text-2xl font-bold">Redefinir a sua palavra-passe</h1>
      <p class="text-muted-foreground text-sm">
        Crie uma nova palavra-passe para a sua conta
      </p>
    </div>
    <div class="grid gap-6">
      <div class="grid gap-3">
        <Label for="password" mandatory>Nova palavra-passe</Label>
        <Input
          type="password"
          placeholder="Introduza a sua nova palavra-passe"
          v-bind="passwordField.inputAttrs.value"
          required
        />
        <FieldError
          :show="passwordField.isTouched.value"
          :message="passwordField.errorMessage.value"
        />
      </div>
      <div class="grid gap-3">
        <Label for="password_confirmation" mandatory
          >Confirmar nova palavra-passe</Label
        >
        <Input
          type="password"
          placeholder="Confirme a sua nova palavra-passe"
          v-bind="passwordConfirmationField.inputAttrs.value"
          required
        />
        <FieldError
          :show="passwordConfirmationField.isTouched.value"
          :message="passwordConfirmationField.errorMessage.value"
        />
      </div>
      <Button
        type="button"
        class="w-full"
        :disabled="form.isValidating.value"
        :aria-busy="form.isValidating.value"
        @click="form.submit()"
      >
        <span role="status" aria-live="polite">
          {{ form.isValidating.value ? "A validar..." : "Redefinir" }}
        </span>
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
