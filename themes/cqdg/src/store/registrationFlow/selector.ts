import { RootState } from "store/types";
import { initialState } from "store/registrationFlow/types";

export type UserProps = initialState;

export const registrationFlowSelector = (state: RootState) => {
  return state.registrationFlow;
};
