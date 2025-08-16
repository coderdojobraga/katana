<script setup lang="ts">
import { Ref, ref } from "vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useLiveVue } from "live_vue";

const live = useLiveVue();

const form: Ref<{ email: string }> = ref({
  email: "",
});

const isSubmitting = ref(false);

const submit = () => {
  isSubmitting.value = true;

  live.pushEvent(
    "send_email",
    {
      user: { email: form.value.email },
    },
    (_reply: any, _ref: Ref) => {
      isSubmitting.value = false;
    },
  );
};
</script>

<template>
  <form @submit.prevent="submit" class="flex flex-col gap-6">
    <div class="flex flex-col items-center gap-2 text-center">
      <h1 class="text-2xl font-bold">Forgot your password?</h1>
      <p class="text-muted-foreground text-sm">
        Enter the email address associated with your account and we'll send you
        a link to reset your password
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
  	:disabled="!form.email || isSubmitting"
  	type="submit"
  	class="w-full"
  	:aria-busy="isSubmitting"
	>
  	<span role="status" aria-live="polite">
    	{{ isSubmitting ? "Sending..." : "Send reset link" }}
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
