"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[5188],{43914:(e,t,a)=>{a.d(t,{D:()=>c});var n=a(67294),l=a(96206),r=a(76439),i=a(46259),s=a(56802),o=a(61290);const c=({id:e,children:t,targetURI:a,fadeOut:c=!1})=>{const m=(0,n.useCallback)((()=>{window.open((0,i.cd)(a).href)}),[a]),d={getTitle:()=>l.ag.get("action-trigger.available-in-app-only"),getDescription:()=>l.ag.get("action-trigger.listen-mixed-media-episode"),primaryButtonText:()=>l.ag.get("action-trigger.button.get-app"),secondaryButtonText:()=>l.ag.get("action-trigger.button.not-now"),isCTA:!0,intentPrimaryButton:"download-app",onLogInteraction:(0,s.o)(),shouldHideOnScroll:!0,fadeOut:c};return n.createElement(r.P,{className:o.Z.container,id:e,onPrimaryButtonClick:m,options:d},t)}},16061:(e,t,a)=>{a.d(t,{B:()=>w});var n=a(87462),l=a(67294),r=a(96206),i=a(18261),s=a(87257),o=a(57978),c=a(80418),m=a(34325),d=a(43315),u=a(49961),g=a(25988),p=a(36590),h=a(8498),E=a(28760),b=a(97605),k=a(85392);const f="z4popIk32AsyDKlV1o1v",C="_xxuonqkZEQ7pCffxlUD",y=l.memo((function(e){const{src:t,description:a,...r}=e,[i,s]=(0,l.useState)("inherit");return(0,l.useEffect)((()=>{t&&async function(e){const{colorRaw:t}=await(0,k.b)(e),{h:a,s:n,l}=t.hsl,r=`hsl(${360*a}, ${100*n}%, ${Math.min(100*l,30)}%)`;s(r)}(t)}),[t]),t?l.createElement("div",{className:f,style:{backgroundColor:i},"data-testid":"episode-fallback-image-container"},l.createElement("div",{className:C},l.createElement(E.Dy,{as:"p",variant:"canon"},a))):l.createElement(b.J,(0,n.Z)({},r,{iconSize:64}))}));var x=a(13781),N=a(11186);const S="x1FErCk9Xh9VumpOLyfm",_="heeHk6hz8sAXLIU6P6an",v="Hhfi1xnYwoHoMP2rcltS",w=({description:e,isExplicit:t,images:a,name:E,uri:b,durationMilliseconds:k,releaseDate:f,resume_point:C,showImages:w,sharingInfo:T,is19PlusOnly:I,isHero:D,onClick:L,testId:B,index:P,requestId:F})=>{let U;const X=f?new Date(f):void 0,Z=X&&!isNaN(X.getTime())&&!isNaN(k),M=(0,u.X)(w,{desiredSize:48}),O=(0,m.G3)(b,X?.toISOString(),C?.resume_position_ms,C?.fully_played);return U=D?l.createElement(x.Z,{index:P,onClick:L,headerText:E,featureIdentifier:"episode",uri:b,isPlayable:!1,isDownloadable:!0,hasNewEpisodeIndicator:O,renderCardImage:()=>l.createElement(h.x,{isHero:!0,images:a,FallbackComponent:t=>l.createElement(y,(0,n.Z)({},t,{description:e,src:M&&M.url}))},M&&l.createElement(c.E,{loading:"lazy",src:M.url,className:S,radius:4})),renderSubHeaderContent:()=>l.createElement(l.Fragment,null,t&&!I&&l.createElement(s.N,{className:_}),I&&l.createElement(o.X,{size:16,className:_}),Z&&l.createElement("span",{className:v},X&&(0,d.rL)(X)," ·"," ",r.ag.get("episode.length",Math.ceil(k/6e4))),l.createElement(N.k,null,r.ag.get("card.tag.episode"))),testId:B,requestId:F}):l.createElement(p.C,{index:P,onClick:L,headerText:E,featureIdentifier:"episode",uri:b,isPlayable:!1,isDownloadable:!0,hasNewEpisodeIndicator:O,renderCardImage:()=>l.createElement(h.x,{images:a,FallbackComponent:t=>l.createElement(y,(0,n.Z)({},t,{description:e,src:M&&M.url}))},M&&l.createElement(c.E,{loading:"lazy",src:M.url,className:S,radius:4,testid:"episode-card-show-image"})),renderSubHeaderContent:()=>l.createElement(l.Fragment,null,t&&!I&&l.createElement(s.N,{className:_}),I&&l.createElement(o.X,{size:16,className:_}),Z&&l.createElement("span",{className:v},X&&(0,d.rL)(X)," ·"," ",r.ag.get("episode.length",Math.ceil(k/6e4)))),testId:B,requestId:F}),l.createElement(i._,{menu:l.createElement(g.k,{uri:b,sharingInfo:T})},U)}},70369:(e,t,a)=>{a.d(t,{$:()=>n.$});var n=a(22578)},31610:(e,t,a)=>{a.d(t,{o:()=>c,q:()=>i.q});var n=a(67294),l=a(4236),r=a(4383),i=a(90110),s=a(56802);const o=n.memo((function({uri:e,bookUri:t,size:a=i.q.md,className:o,onClick:c=(()=>{})}){const[m,d]=(0,r.Z)(t),u=(0,s.o)(),g=(0,l.k)(),p=(0,n.useCallback)((()=>{u({targetUri:t,intent:"add-to-library",type:"click"}),d(!0)}),[u,t,d]);return n.createElement(i.o,{className:o,isFollowing:m,canDownload:g,onFollow:p,uri:e,size:a,onClick:c})})),c=n.memo((function(e){return n.createElement(o,e)}))},80219:(e,t,a)=>{a.d(t,{s:()=>u});var n=a(67294),l=a(56802);const r=e=>e<=64?"small":e>640?"xlarge":e>300?"large":"standard";function i(e,t){return e.filter((e=>e.label?e.label===t:e.width?r(e.width)===t:!!e.height&&r(e.height)===t))[0]}var s=a(67789);function o(e){const t=i(e,"standard"),a=i(e,"large"),n=i(e,"small"),l=i(e,"xlarge");return{image_url:t?.url,image_height:t?.height?.toString(),image_width:t?.width?.toString(),image_url_large:a?.url,image_height_large:a?.height?.toString(),image_width_large:a?.width?.toString(),image_url_small:n?.url,image_height_small:n?.height?.toString(),image_width_small:n?.width?.toString(),image_url_xlarge:l?.url,image_height_xlarge:l?.height?.toString(),image_width_xlarge:l?.width?.toString()}}var c=a(23716),m=a(69691),d=a(42781);function u(e,t){const a=(0,l.o)(),r=(0,c.g)(),{isPlaying:i,isActive:u}=(0,m.$o)(e?.uri||""),{isActive:g}=(0,m.cR)(t?.uri||"");return(0,n.useCallback)((n=>{if(!t||!e)return;const l=function(e,t){const a=(e.coverArt?.sources||[]).sort(((e,t)=>(t.width||0)-(e.width||0))),n=(0,s.Xb)(e,t),l=(0,s.Ie)(t)||n;return{uri:e.uri,title:e.name,subtitle:t.name,type:"episode",album_uri:t.uri,album_title:t.name,artist_uri:t.uri,artist_name:t.name,...o(a),media_type:"audio",externalResolvedUrl:e.audio?.items?.find((e=>e.externallyHosted))?.url,isTrailer:n,anonymousPlaybackAllowed:l}}(e,t);g&&!i&&u&&!n?r.resume():g&&i&&!n?(a({type:"click",intent:"pause",targetUri:e.uri}),r.pause()):(a({type:"click",intent:"play",targetUri:e.uri}),r.play({uri:t.uri,pages:[{items:[{type:d.p.EPISODE,uri:e.uri,uid:null,metadata:l,provider:null}]}]},{referrerIdentifier:r.getReferrer(),featureIdentifier:"episode"},n))}),[u,i,g,r,a,t,e])}},20238:(e,t,a)=>{a.d(t,{o:()=>F});var n=a(67294),l=a(96206);const r="CTqnyEX1E8bCstZSENX_",i="wuGkmgD03o8t6Ekc6PUk",s="l1ZEvEBLXHaRxKZTgG2Q",o="KXlcyuHuR1UPYVsnF3zF";var c=a(69559),m=a(28760),d=a(52865),u=a(58548);const g=/(\((?:[0-9]{1,3}:){1,2}[0-9]{2}\))/g;function p(e){return e.split(g).map((e=>{if(e.match(g)){return`(<time>${e.replace("(","").replace(")","")}</time>)`}return e})).join("")}const h=n.memo((function({text:e,onTimeStampClick:t,children:a,className:l,LinkComponent:r,enableTimestamps:i=!1}){const s=(0,n.useMemo)((()=>{const a=(0,d.ZU)(e),l=i?p(a):a;return n.createElement(u.NB,{source:l,LinkComponent:r,onTimeStampClick:t})}),[e,i,r,t]);return n.createElement(m.Dy,{as:"p",variant:"ballad",className:l},s,a)})),E="AFGg70Z_GfjSDTYBWyEq",b=n.memo((function({text:e,onTimeStampClick:t,onToggle:a,className:r,LinkComponent:i,enableTimestamps:s}){return n.createElement(h,{className:r,text:e,onTimeStampClick:t,LinkComponent:i,enableTimestamps:s},n.createElement("button",{"aria-expanded":!1,className:E,onClick:a},n.createElement(m.Dy,{variant:"balladBold"},"… ",l.ag.get("mwp.see.more"))))})),k=(e,t,a)=>{const n=l.ag.get("mwp.see.more").length,r=e.length+n+6;return a<=1&&r<t},f=n.memo((function({paragraphs:e,clickHandler:t,maxCharactersPerLine:a,maxLines:r,toggleExpandedState:i,LinkComponent:s,className:o,enableTimestamps:c}){let m=!1,d=0;const u=e.map(((u,g)=>{const p=Math.round(u.length/a);if(d+=p>0?p:1,m)return null;const E=r-(d-p);if(g+1===e.length&&(k(u,a,E)||p<=E))return n.createElement(h,{className:o,text:u,onTimeStampClick:t,LinkComponent:s,enableTimestamps:c,key:g});if(d>=r){m=!0;const e=((e,t,a)=>{const n=l.ag.get("mwp.see.more").length;if(k(e,t,a))return e;const r=t*a-n-6;return e.slice(0,r)})(u,a,E);return n.createElement(b,{key:g,text:e,onTimeStampClick:t,onToggle:i,className:o,LinkComponent:s,enableTimestamps:c})}return n.createElement(h,{className:o,text:u,onTimeStampClick:t,LinkComponent:s,enableTimestamps:c,key:g})}));return n.createElement(n.Fragment,null,u)}));var C=a(65598),y=a.n(C),x=a(19594),N=a(67892);const S="xgmjVLxjqfcXK5BV_XyN",_="QD13ZfPiO5otS0PU89wG",v="ZbLneLRe2x_OBOYZMX3M",w="rjdQaIDkSgcGmxkdI2vU",T="umouqjSkMUbvF4I_Xz6r",I=n.memo((function({html:e,onTimeStampClick:t,enableTimestamps:a=!1}){const l=(0,n.useMemo)((()=>{const n=a?p(e):e;return y()(n,{transform:D(t),dangerouslySetChildren:[]})}),[a,e,t]);return n.createElement("div",{className:S},l)}));function D(e){let t=0;return{p:e=>n.createElement(m.Dy,{as:"p",variant:"ballad",semanticColor:"textSubdued",className:T},e.children),a:t=>t.href?.startsWith("#t=")?n.createElement(x.E,{onClick:e},t.children):t.href?n.createElement(N.r,{to:t.href},t.children):n.createElement(n.Fragment,null,t.children),ul:e=>n.createElement("ul",{className:v},e.children),ol:e=>n.createElement("ol",{className:v},e.children),li:e=>n.createElement(m.Dy,{as:"li",variant:"ballad",semanticColor:"textSubdued",className:w},e.children),br:()=>n.createElement("br",null),h1:e=>n.createElement(m.Dy,{as:"h1",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),h2:e=>n.createElement(m.Dy,{as:"h2",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),h3:e=>n.createElement(m.Dy,{as:"h3",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),h4:e=>n.createElement(m.Dy,{as:"h4",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),h5:e=>n.createElement(m.Dy,{as:"h5",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),h6:e=>n.createElement(m.Dy,{as:"h6",variant:"balladBold",semanticColor:"textSubdued",className:_},e.children),time:t=>n.createElement(x.E,{onClick:e},t.children),_:(e,a,l)=>{const r=void 0===a?e:l;return n.createElement(n.Fragment,{key:"fragment"+t++},r)}}}const L={isOpen:!1,contentWidth:0},B=(e,t)=>({...e,...t}),P=(e="")=>e.split(/[ \u00a0]{2}/).filter(Boolean),F=n.memo((function({content:e,htmlContent:t,maxLines:a=2,className:d,onTimeStampClick:u=(()=>{}),LinkComponent:g,onExpanded:p,enableTimestamps:E=!1}){const[b,k]=(0,n.useReducer)(B,L),{isOpen:C,contentWidth:y}=b,x=(0,n.useCallback)((()=>{k({isOpen:!C}),p&&p(!C)}),[C,p]);(0,n.useEffect)((()=>{k({isOpen:!1})}),[e]);const N=y?y/7.8:Number.MAX_VALUE,S=(0,n.useRef)(null),_=(0,n.useCallback)((e=>{e&&(S.current=e,k({contentWidth:e.clientWidth}))}),[]),v=(0,n.useMemo)((()=>t?n.createElement(I,{html:t,onTimeStampClick:u,enableTimestamps:E}):((e,t,a,l)=>P(e).map(((e,r)=>n.createElement(h,{className:i,text:e,onTimeStampClick:t,enableTimestamps:a,LinkComponent:l,key:r}))))(e,u,E,g)),[g,e,E,t,u]),w=(0,n.useMemo)((()=>t?((e="")=>e.replace("<p>","").split(/(?:<\/p>)/).filter(Boolean))(t):P(e)),[e,t]);return(0,c.a)((()=>{S.current&&k({contentWidth:S.current.clientWidth})})),n.createElement("div",{className:d},n.createElement("div",{ref:_,className:r},C&&n.createElement(n.Fragment,null,v,n.createElement("button",{"aria-expanded":!0,className:o,onClick:x},n.createElement(m.Dy,{className:s,variant:"balladBold"},l.ag.get("show_less")))),!C&&n.createElement(f,{className:i,paragraphs:w,LinkComponent:g,clickHandler:u,enableTimestamps:E,maxCharactersPerLine:N,maxLines:a,toggleExpandedState:x})))}))},60410:(e,t,a)=>{a.d(t,{S:()=>l,g:()=>r});var n=a(86649);function l(e){return!e.playability?.playable&&e.playability?.reason===n.WY.PaymentRequired}function r(e){return!!e&&e.some(l)}}}]);
//# sourceMappingURL=5188.js.map