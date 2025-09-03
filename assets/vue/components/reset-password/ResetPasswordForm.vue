<script setup lang="ts">
import { type Form, Link, useLiveForm } from "live_vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { FieldError } from "@/components/ui/field-error";

type ResetPasswordFields = {
  password: string;
  password_confirmation: string;
};

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
      <h1 class="text-2xl font-bold">Reset your password</h1>
      <p class="text-muted-foreground text-sm">
        Create a new password for your account
      </p>
    </div>
    <div class="grid gap-6">
      <div class="grid gap-3">
        <Label for="password" mandatory>New password</Label>
        <Input
          type="password"
          placeholder="Enter your new password"
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
          >Confirm new password</Label
        >
        <Input
          type="password"
          placeholder="Confirm your new password"
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
          {{ form.isValidating.value ? "Validating..." : "Reset" }}
        </span>
      </Button>
    </div>
    <div class="text-center text-sm">
      Remember your password?
      <Link navigate="/users/log_in" class="underline underline-offset-4">
        Log in
      </Link>
    </div>
  </form>
</template>
