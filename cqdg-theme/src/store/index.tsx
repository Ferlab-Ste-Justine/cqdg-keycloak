import { configureStore } from '@reduxjs/toolkit';
import { combineReducers } from 'redux';

// Reducers
import RegistrationFlowReducer from 'store/registrationFlow';
import { RootState } from 'store/types';

const rootReducer = combineReducers<RootState>({
  registrationFlow: RegistrationFlowReducer,
});

const store: any = configureStore({
  reducer: rootReducer,
  devTools: false,
});

export const getStore = () => store;
