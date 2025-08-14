<script setup lang="ts">
import { Ref, ref } from "vue";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useLiveVue } from "live_vue";

const live = useLiveVue();

const form: Ref<{ email: string; password: string }> = ref({
  email: "",
  password: "",
});

const isSubmitting = ref(false);

const submit = () => {
  isSubmitting.value = true;

  live.pushEvent(
    "submit",
    {
      user: { email: form.value.email, password: form.value.password },
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
      <h1 class="text-2xl font-bold">Log in to your account</h1>
      <p class="text-muted-foreground text-sm">
        Enter your credentials below to log in to your account
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
      <div class="grid gap-3">
        <div class="flex items-center">
          <Label for="password">Password</Label>
          <Link
            navigate="/users/forgot_password"
            class="ml-auto text-sm underline-offset-4 hover:underline"
          >
            Forgot your password?
          </Link>
        </div>
        <Input id="password" type="password" v-model="form.password" required />
      </div>
      <Button
        :disabled="!form.email || !form.password || isSubmitting"
        type="submit"
        class="w-full"
      >
        <span v-if="isSubmitting">Logging in...</span>
        <span v-else>Log in</span>
      </Button>
      <div
        class="after:border-border relative text-center text-sm after:absolute after:inset-0 after:top-1/2 after:z-0 after:flex after:items-center after:border-t"
      >
        <span class="bg-background text-muted-foreground relative z-10 px-2">
          Or continue with
        </span>
      </div>
      <Button variant="outline" class="w-full">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
          <path
            d="M12.48 10.92v3.28h7.84c-.24 1.84-.853 3.187-1.787 4.133-1.147 1.147-2.933 2.4-6.053 2.4-4.827 0-8.6-3.893-8.6-8.72s3.773-8.72 8.6-8.72c2.6 0 4.507 1.027 5.907 2.347l2.307-2.307C18.747 1.44 16.133 0 12.48 0 5.867 0 .307 5.387.307 12s5.56 12 12.173 12c3.573 0 6.267-1.173 8.373-3.36 2.16-2.16 2.84-5.213 2.84-7.667 0-.76-.053-1.467-.173-2.053H12.48z"
            fill="currentColor"
          />
        </svg>
        Log in with Google
      </Button>
    </div>
    <div class="text-center text-sm">
      Don't have an account?
      <Link navigate="/users/register" class="underline underline-offset-4">
        Register here
      </Link>
    </div>
  </form>
</template>
