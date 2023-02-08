import "style/themes/cqdg/dist/antd.css";
import "style/themes/cqdg/main.scss";
import "./index.scss";

import ReactDOM from "react-dom";
import { Provider as ReduxProvider } from "react-redux";
import { defaultKcProps } from "keycloakify";
import { kcContext } from "keycloak/kcContext";
import { KcApp } from "keycloak/KcApp";

import "./keycloak/kcMessagesExtension";
import { getStore } from "store";

const store = getStore();

ReactDOM.render(
  <ReduxProvider store={store}>
    <KcApp
      kcContext={kcContext!}
      {...{
        ...defaultKcProps,
        kcHtmlClass: ["login-mdc"],
      }}
    />{" "}
  </ReduxProvider>,
  document.getElementById("root")
);
