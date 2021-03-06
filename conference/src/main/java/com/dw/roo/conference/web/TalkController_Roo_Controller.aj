// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.conference.web;

import com.dw.roo.conference.domain.Speaker;
import com.dw.roo.conference.domain.Talk;
import java.lang.Long;
import java.lang.String;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TalkController_Roo_Controller {
    
    @Autowired
    private GenericConversionService TalkController.conversionService;
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String TalkController.createForm(Model model) {
        model.addAttribute("talk", new Talk());
        List dependencies = new ArrayList();
        if (Speaker.countSpeakers() == 0) {
            dependencies.add(new String[]{"speaker", "speakers"});
        }
        model.addAttribute("dependencies", dependencies);
        return "talks/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String TalkController.show(@PathVariable("id") Long id, Model model) {
        model.addAttribute("talk", Talk.findTalk(id));
        model.addAttribute("itemId", id);
        return "talks/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String TalkController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("talks", Talk.findTalkEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Talk.countTalks() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("talks", Talk.findAllTalks());
        }
        return "talks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String TalkController.update(@Valid Talk talk, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("talk", talk);
            return "talks/update";
        }
        talk.merge();
        return "redirect:/talks/" + encodeUrlPathSegment(talk.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String TalkController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("talk", Talk.findTalk(id));
        return "talks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String TalkController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Talk.findTalk(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/talks?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @ModelAttribute("speakers")
    public Collection<Speaker> TalkController.populateSpeakers() {
        return Speaker.findAllSpeakers();
    }
    
    Converter<Speaker, String> TalkController.getSpeakerConverter() {
        return new Converter<Speaker, String>() {
            public String convert(Speaker speaker) {
                return new StringBuilder().append(speaker.getFirstname()).append(" ").append(speaker.getLastname()).append(" ").append(speaker.getEmail()).toString();
            }
        };
    }
    
    Converter<Talk, String> TalkController.getTalkConverter() {
        return new Converter<Talk, String>() {
            public String convert(Talk talk) {
                return new StringBuilder().append(talk.getTitle()).append(" ").append(talk.getDescription()).toString();
            }
        };
    }
    
    @PostConstruct
    void TalkController.registerConverters() {
        conversionService.addConverter(getSpeakerConverter());
        conversionService.addConverter(getTalkConverter());
    }
    
}
