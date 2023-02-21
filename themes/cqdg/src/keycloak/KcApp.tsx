import { memo } from "react";

import { Info } from "keycloakify/lib/components/Info";
import { KcApp as KcAppBase } from "keycloakify/lib/components/KcApp";
import "./kcMessagesExtension";
import type { KcContext } from "./kcContext";
import { KcProps } from "keycloakify/lib/components/KcProps";
import { Error } from "views/Error";
import Login from "views/Login";
import Registration from "views/Registration";

export const KcApp = memo(
  ({ kcContext, ...props }: { kcContext: KcContext } & KcProps) => {
    switch (kcContext.pageId) {
      case "login.ftl":
        return <Login {...{ kcContext, ...props }} />;
      case "login-update-profile.ftl":
        return <Registration {...{ kcContext, ...props }} />;
      case "info.ftl":
        return <Info {...{ kcContext, ...props }} />;
      case "error.ftl":
        return <Error {...{ kcContext, ...props }} />;
      default:
        return <KcAppBase {...{ kcContext, ...props }} />;
    }
  }
);
