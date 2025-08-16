<script setup lang="ts">
import { toRef } from "vue";
import { Form, Link, useLiveForm } from "live_vue";
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

const { submit, form, fields, isSubmitting } = useLiveForm<ResetPasswordFields>(
  toRef(props, "form"),
  {
    changeEvent: "validate",
    submitEvent: "reset_password",
  },
);

const password = fields["password"];
const passwordConfirmation = fields["password_confirmation"];
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
          id="password"
          type="password"
          placeholder="Enter your new password"
          v-model="password.value"
          :name="password.name"
          required
        />
        <FieldError :show="password.touched" :message="password.errorMessage" />
      </div>
      <div class="grid gap-3">
        <Label for="password_confirmation" mandatory
          >Confirm new password</Label
        >
        <Input
          id="password_confirmation"
          type="password"
          placeholder="Confirm your new password"
          v-model="passwordConfirmation.value"
          :name="passwordConfirmation.name"
          required
        />
        <FieldError
          :show="passwordConfirmation.touched"
          :message="passwordConfirmation.errorMessage"
        />
      </div>
      <Button
        :disabled="
          (form.touched && !form.meta.valid) || isSubmitting || !form.meta.dirty
        "
        type="button"
        @click="submit"
        class="w-full"
      >
        <span v-if="isSubmitting">Resetting...</span>
        <span v-else>Reset</span>
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
