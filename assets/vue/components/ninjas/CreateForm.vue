<script setup lang="ts">
import { ref, computed, Ref } from 'vue';
import { CalendarIcon } from 'lucide-vue-next';
import { CalendarDate } from '@internationalized/date';

import { useLiveVue } from 'live_vue';

import { Button } from '../ui/button';
import { Input } from '../ui/input';
import { Textarea } from '../ui/textarea';
import { Checkbox } from '../ui/checkbox';
import { Switch } from '../ui/switch';
import { Popover, PopoverContent, PopoverTrigger } from '../ui/popover';
import { Calendar } from '../ui/calendar';
import { RadioGroup, RadioGroupItem } from '../ui/radio-group';

const ninja = ref({
  full_name: '',
  birth_date: undefined as CalendarDate | undefined,
  has_attended_before: false,
  number_of_sessions: '0',
  coderdojo_experience_description: '',
  programming_experience_description: '',
  has_medical_condition: false,
  medical_condition_details: '',
  additional_info: '',
  image_consent: false,
});

const formattedBirthDate = computed(() => {
  if (!ninja.value.birth_date) return 'Pick a date';
  const d = ninja.value.birth_date.toDate('UTC');
  return d.toLocaleDateString('pt-PT');
});

const isSubmitting = ref(false);
const live = useLiveVue();

function handleSubmit() {
  isSubmitting.value = true;

  live.pushEvent(
    'submit',
    {
      ninja,
    },
    (_reply: any, _ref: Ref) => {
      isSubmitting.value = false;
    },
  );
}
</script>

<template>
  <form
    class="max-w-3xl mx-auto bg-white p-8 rounded-2xl space-y-6"
    @submit.prevent="handleSubmit"
  >
    <h2 class="text-2xl font-bold text-gray-800 mb-4">Registo do Ninja</h2>

    <!-- Full Name -->
    <label class="text-sm font-semibold text-gray-700"
      >Nome completo do ninja</label
    >
    <Input
      v-model="ninja.full_name"
      placeholder="Introduza o nome completo"
      class="w-full"
    />

    <!-- Birth Date -->
    <label class="text-sm font-semibold text-gray-700"
      >Data de nascimento do ninja</label
    >
    <Popover>
      <PopoverTrigger as-child>
        <Button
          variant="outline"
          class="w-full pl-3 text-left font-normal flex items-center justify-between"
        >
          <span>{{ formattedBirthDate }}</span>
          <CalendarIcon class="h-5 w-5 text-gray-400" />
        </Button>
      </PopoverTrigger>
      <PopoverContent class="w-auto p-0" align="start">
        <Calendar v-model="ninja.birth_date" mode="single" initial-focus />
      </PopoverContent>
    </Popover>

    <!-- Has attended before -->
    <label class="flex items-center space-x-2 text-sm text-gray-700">
      <Checkbox v-model:checked="ninja.has_attended_before" id="attended"  class="mr-4"/>
      O seu ninja já participou no CoderDojo?
    </label>

    <!-- Number of sessions -->
    <label class="text-sm font-semibold text-gray-700"
      >Número de sessões do ninja</label
    >
    <RadioGroup v-model="ninja.number_of_sessions" class="flex gap-4">
      <div class="flex items-center space-x-2">
        <RadioGroupItem value="0" id="sessions-0" />
        <label for="sessions-0" class="text-sm text-gray-700">0</label>
      </div>
      <div class="flex items-center space-x-2">
        <RadioGroupItem value="1-2" id="sessions-1" />
        <label for="sessions-1" class="text-sm text-gray-700">1–2</label>
      </div>
      <div class="flex items-center space-x-2">
        <RadioGroupItem value="3-4" id="sessions-3" />
        <label for="sessions-3" class="text-sm text-gray-700">3–4</label>
      </div>
      <div class="flex items-center space-x-2">
        <RadioGroupItem value="5+" id="sessions-5" />
        <label for="sessions-5" class="text-sm text-gray-700">5+</label>
      </div>
    </RadioGroup>

    <!-- CoderDojo Experience -->
    <label class="text-sm font-semibold text-gray-700"
      >Experiência do ninja no CoderDojo</label
    >
    <Textarea
      v-model="ninja.coderdojo_experience_description"
      placeholder="Descreva a experiência no CoderDojo"
      class="w-full"
    />

    <!-- Programming Experience -->
    <label class="text-sm font-semibold text-gray-700"
      >Experiência do ninja com programação</label
    >
    <Textarea
      v-model="ninja.programming_experience_description"
      placeholder="Descreva a experiência em programação"
      class="w-full"
    />

    <!-- Medical Condition -->
    <label class="flex items-center space-x-2 text-sm text-gray-700">
      <Checkbox v-model:checked="ninja.has_medical_condition" id="medical"  class="mr-4"/>
      O ninja tem alguma condição médica?
    </label>

    <!-- Medical Condition Details -->
    <div v-if="ninja.has_medical_condition" class="space-y-1">
      <label class="text-sm font-semibold text-gray-700">Detalhes</label>
      <Textarea
        v-model="ninja.medical_condition_details"
        placeholder="Forneça detalhes, se houver"
        class="w-full"
      />
    </div>

    <!-- Additional Info -->
    <label class="text-sm font-semibold text-gray-700"
      >Informação adicional sobre o seu ninja</label
    >
    <Textarea
      v-model="ninja.additional_info"
      placeholder="Algo mais que devamos saber?"
      class="w-full"
    />

    <!-- Image Consent -->
    <label class="flex items-center text-sm text-gray-700">
      <Switch v-model:checked="ninja.image_consent" id="consent" class="mr-4"/>
      Consente a utilização ?
    </label>

    <!-- Submit -->
    <Button type="submit" class="w-full text-white font-semibold">
      {{isSubmitting ? 'Criando...' : 'Criar Ninja'}}
    </Button>
  </form>
</template>
