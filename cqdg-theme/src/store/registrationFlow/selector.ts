import { initialState } from 'store/registrationFlow/types';
import { RootState } from 'store/types';

export type UserProps = initialState;

export const registrationFlowSelector = (state: RootState) => state.registrationFlow;
