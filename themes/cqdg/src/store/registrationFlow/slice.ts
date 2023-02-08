import { createSlice } from "@reduxjs/toolkit";
import { initialState } from "store/registrationFlow/types";

const INITIAL_STEP = 1;

export const RegistrationFlowState: initialState = {
  userInfo: null,
  currentStep: INITIAL_STEP,
};

const registrationFlowSlice = createSlice({
  name: "user",
  initialState: RegistrationFlowState,
  reducers: {
    nextStep: (state) => {
      state.currentStep = state.currentStep + 1;
    },
    previousStep: (state) => {
      const previousStep = state.currentStep - 1;
      if (previousStep >= INITIAL_STEP) {
        state.currentStep = previousStep;
      }
    },
    acceptTerms: (state) => {
      state.userInfo = {
        ...state,
        accepted_terms: true,
        understand_disclaimer: true,
      };
    },
  },
});

export const registrationFlowActions = registrationFlowSlice.actions;
export default registrationFlowSlice.reducer;
