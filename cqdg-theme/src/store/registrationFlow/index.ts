import { useSelector } from 'react-redux';

import { registrationFlowSelector } from './selector';

export type { initialState as RegistrationFlowInitialState } from './types';
export { default, RegistrationFlowState } from './slice';
export const useRegistrationFlow = () => useSelector(registrationFlowSelector);
